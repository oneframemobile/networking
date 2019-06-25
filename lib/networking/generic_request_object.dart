import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'network_queue.dart';
import 'request_id.dart';
import 'header.dart';
import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'serializable.dart';
import 'serializable_list.dart';
import 'serializable_object.dart';

class GenericRequestObject<RequestType extends Serializable, ResponseType extends Serializable, ErrorType> {
  Set<Header> _headers;
  ContentType _contentType;
  MethodType _methodType;
  Duration _timeout;
  Uri _uri;
  NetworkLearning _learning;
  HttpClient _client;
  NetworkConfig _config;
  NetworkListener _listener;
  RequestType _body;
  ResponseType _type;
  bool _asList;
  final RequestId id = new RequestId();

  GenericRequestObject(
    this._methodType,
    this._learning,
    this._client,
    this._config, [
    this._body,
  ]) {
    _headers = new Set();
    _timeout = Duration(seconds: 60);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> url(String url) {
    _uri = Uri.parse(_config != null ? _config.baseUrl + url : url);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaders(Iterable<Header> headers) {
    if (headers != null) {
      _headers.addAll(headers);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeader(Header header) {
    if (header != null) {
      _headers.add(header);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> contentType(ContentType contentType) {
    _contentType = contentType;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> timeout(Duration timeout) {
    _timeout = timeout;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> listener(NetworkListener listener) {
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

  GenericRequestObject<RequestType, ResponseType, ErrorType> query(String key, String value) {
    _uri = Uri.parse(_uri.toString() + "?$key=$value");
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> path(String path) {
    _uri = Uri.parse(_uri.toString() + "/$path");
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

  Future<dynamic> fetch() async {
    Future future = Future.value(dynamic);

    try {
      var request = await _request();

      if (_config != null) {
        _headers.addAll(_config.headers);
      }

      _headers.forEach((header) => request.headers.add(header.key, header.value));

      if (_methodType == MethodType.POST) {
        request.headers.add(
          HttpHeaders.contentTypeHeader,
          _contentType == null ? ContentType.json.toString() : _contentType.toString(),
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
      response.timeout(_config != null ? _config.timeout : _timeout);

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
          return _learning.checkSuccess(_listener, model);
        } else {
          _listener.result(model);
          return Future.value(model);
        }
      } else {
        ErrorModel<ErrorType> error = new ErrorModel();
        error.description = response.reasonPhrase;
        error.statusCode = response.statusCode;
        error.raw = buffer.toString();
        _listener.error(error);

        return Future.error(error);
      }
    } on SocketException catch (exception) {
      ErrorModel<ErrorType> error = new ErrorModel<ErrorType>();
      error.description = exception.message;
      error.type = NetworkErrorTypes.NETWORK_ERROR;
      _listener.error(error as dynamic);
    } on TimeoutException catch (exception) {
      ErrorModel<ErrorType> error = new ErrorModel<ErrorType>();
      error.description = exception.message;
      error.type = NetworkErrorTypes.TIMEOUT_ERROR;
      _listener.error(error as dynamic);
    }

    return future;
  }

  void enqueue() {
    NetworkQueue.instance.add(this);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is GenericRequestObject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
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
