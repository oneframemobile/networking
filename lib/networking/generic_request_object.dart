import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'header.dart';
import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'serializable.dart';
import 'serializable_list.dart';
import 'serializable_object.dart';

class GenericRequestObject<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable> {
  List<Header> _headers;
  MethodType _methodType;
  Uri _uri;
  NetworkListener<ResponseType, Serializable> _listener;
  NetworkLearning _learning;
  HttpClient _client;
  NetworkConfig _config;
  Serializable<RequestType> _body;
  ResponseType _type;
  Serializable<ErrorType> _error;
  bool _asList;

  GenericRequestObject(
      this._methodType,
      this._learning,
      this._client,
      this._config, [
        this._body,
      ]) {
    _headers = [];
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> url(String url) {
    _uri = Uri.parse(url);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaders(Iterable<Header> iterable) {
    _headers.addAll(iterable);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeader(Header header) {
    _headers.add(header);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> listener(NetworkListener<ResponseType, Serializable> listener) {
    _listener = listener;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> type(ResponseType type) {
    _type = type;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> asList(bool asList) {
    _asList = asList;
    return this;
  }

  Future<HttpClientRequest> _request() {
    switch (_methodType) {
      case MethodType.GET:
        return _client.getUrl(_uri);
      case MethodType.POST:
        return _client.postUrl(_uri);
      case MethodType.PUT:
        return _client.putUrl(_uri);
      case MethodType.DELETE:
        return _client.deleteUrl(_uri);
      case MethodType.UPDATE:
        return _client.patchUrl(_uri);
    }

    throw new Exception("Unknown method type");
  }

  void fetch() async {
    try {
      var request = await _request();

      if (_config != null) {
        _config.headers.forEach(
              (header) => request.headers.add(header.key, header.value),
        );
      }

      if (_methodType == MethodType.POST) {
        request.headers.add(
          HttpHeaders.contentTypeHeader,
          ContentType.json.toString(),
        );

        if (_body != null) {
          if (_body is SerializableObject) {
            SerializableObject serializable = _body as SerializableObject;
            var map = json.encode(serializable.toJson());
            request.write(map);
          } else if (_body is SerializableList) {
            SerializableList serializable = _body as SerializableList;
            var map = json.encode(serializable.toJsonList());
            request.write(map);
          }
        }
      }

      var response = await request.close();
      var buffer = new StringBuffer();
      await for (var contents in response.transform(Utf8Decoder())) {
        buffer.write(contents);
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ResultModel<ResponseType> model = new ResultModel();
        model.result = buffer.toString();
        model.url = _uri.toString();
        if (!_asList) {
          var map = json.decode(buffer.toString());
          var serializable = (_type as SerializableObject);
          model.data = serializable.fromJson(map);
          model.json = map;
        } else {
          Iterable iterable = json.decode(buffer.toString());
          var serializable = (_type as SerializableList);
          serializable.list = serializable.fromJsonList(iterable);
          model.data = _type;
          model.jsonList = iterable;
        }

        if (_learning != null) {
          _learning.checkSuccess(_listener, model);
        } else {
          _listener.result(model);
        }
      } else {
        ErrorModel error;
        if (_error is SerializableObject) {
          var map = json.decode(buffer.toString());

          error = new ErrorModel<ErrorType>();
          error.data = (_error as SerializableObject).fromJson(map);
        } else if (_error is SerializableList) {
          Iterable iterable = json.decode(buffer.toString());

          error = new ErrorModel<List<ErrorType>>();
          error.data = (_type as SerializableList).fromJsonList(iterable);
        }

        error.description = response.reasonPhrase;
        error.errorCode = response.statusCode;
        _listener.error(error);
      }
    } on SocketException catch (exception) {
      ErrorModel<ErrorType> error = new ErrorModel<ErrorType>();
      error.description = exception.message;
      error.type = NetworkErrorTypes.NETWORK_ERROR;
      _listener.error(error as dynamic);
    }
  }
}

enum MethodType {
  GET,
  POST,
  PUT,
  DELETE,
  UPDATE,
}

enum NetworkErrorTypes {
  NO_CONNECTION_ERROR,
  TIMEOUT_ERROR,
  AUTH_FAILURE_ERROR,
  SERVER_ERROR,
  NETWORK_ERROR,
  PARSE_ERROR,
  CLIENT_ERROR,
}
