import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'header.dart';
import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'network_queue.dart';
import 'request_id.dart';
import 'serializable.dart';
import 'serializable_list.dart';
import 'serializable_object.dart';

class GenericRequestObject<RequestType extends Serializable,
    ResponseType extends Serializable, ErrorType extends Serializable> {
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
  ErrorType _errorType;
  Set<Cookie> _cookies;

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
    _cookies = new Set();
    _timeout = Duration(seconds: 60);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> url(String url) {
    _uri = Uri.parse(_config != null ? _config.baseUrl + url : url);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaders(
      Iterable<Header> headers) {
    if (headers != null) {
      _headers.addAll(headers);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeader(
      Header header) {
    if (header != null) {
      /// check same headers value. if some value income remove older value and update [header]
      if (_headers.contains(header)) {
        _headers.removeWhere((header) => header.key == header.key);
        print(_headers.length);
        _headers.add(header);
      } else {
        _headers.add(header);
      }
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addCookies(
      Iterable<Cookie> cookies) {
    if (cookies != null) {
      _cookies.addAll(cookies);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addCookie(
      Cookie cookie) {
    if (cookie != null) {
      _cookies.add(cookie);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addQuery(
      String key, String value) {
    if (_uri.toString().contains("?")) {
      _uri = Uri.parse(_uri.toString() + "&$key=$value");
    } else {
      _uri = Uri.parse(_uri.toString() + "?$key=$value");
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType>
      addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> contentType(
      ContentType contentType) {
    _contentType = contentType;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> timeout(
      Duration timeout) {
    _timeout = timeout;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> listener(
      NetworkListener listener) {
    _listener = listener;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> type(
      ResponseType type) {
    _type = type;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> errorType(
      ErrorType type) {
    _errorType = type;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> asList(
      bool asList) {
    _asList = asList;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> query(
      String key, String value) {
    _uri = Uri.parse(_uri.toString() + "?$key=$value");
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> path(String path) {
    _uri = Uri.parse(_uri.toString() + "/$path");
    return this;
  }

  Future<HttpClientRequest> _request() {
    final client = HttpClient();
    switch (_methodType) {
      case MethodType.GET:
        return client.getUrl(_uri);
      case MethodType.POST:
        return client.postUrl(_uri);
      case MethodType.PUT:
        return client.putUrl(_uri);
      case MethodType.DELETE:
        return client.deleteUrl(_uri);
      case MethodType.UPDATE:
        return client.patchUrl(_uri);
    }

    throw new Exception("Unknown method type");
  }

  Future<dynamic> fetch() async {
    try {
      var request = await _request();

      _cookies?.forEach((cookie) => request.cookies.add(cookie));
      _headers
          .forEach((header) => request.headers.add(header.key, header.value));

      if (_methodType == MethodType.POST || _methodType == MethodType.PUT) {
        request.headers.add(
          HttpHeaders.contentTypeHeader,
          _contentType == null
              ? ContentType.json.toString()
              : _contentType.toString(),
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
        ResultModel model = ResultModel();
        model.result = buffer.toString();
        model.url = _uri.toString();

        // check cookkies
        if (response.cookies != null) {
          model.cookies = response.cookies;
        }

        // check empty or return single value
        if (buffer.isEmpty || !buffer.toString().contains(":") && !_asList) {
          var map = new Map<String, dynamic>();
          var serializable = (_type as SerializableObject);
          model.data = serializable.fromJson(map);
          model.json = map;
        } else {
          var map = json.decode(buffer.toString());
          model.jsonString = buffer.toString();
          var serializable = (_type as SerializableObject);

          // result list control
          if (map is List)
            model.data = fromJsonList(map, _type);
          else
            model.data = serializable.fromJson(map);
        }

        await request.done;
        if (_learning != null)
          return _learning.checkSuccess<ResponseType>(_listener, model);
        else {
          _listener?.result(model);
          return model;
        }
      } else {
        ErrorModel<ErrorType> error = new ErrorModel();
        error.description = response.reasonPhrase;
        error.statusCode = response.statusCode;
        error.raw = buffer.toString();
        error.request = this;

        if (_learning != null)
          return await _learning.checkCustomError(_listener, error);
        else {
          _listener?.error(error);
          throw (error);
        }
      }
    } on SocketException catch (exception) {
      return customErrorHandler(exception, NetworkErrorTypes.NETWORK_ERROR);
    } on TimeoutException catch (exception) {
      return customErrorHandler(exception, NetworkErrorTypes.TIMEOUT_ERROR);
    }
  }

  List fromJsonList(List json, dynamic model) {
    return json
        .map((fields) => model.fromJson(fields))
        .cast<ResponseType>()
        .toList();
  }

  void customErrorHandler(exception, NetworkErrorTypes types) {
    ErrorModel<ErrorType> error = new ErrorModel<ErrorType>();
    error.description = exception.message;
    error.type = types;
    error.request = this;

    _listener?.error(error);

    if (_learning != null)
      throw _learning.checkCustomError(_listener, error);
    else
      throw (error);
  }

  void enqueue() {
    NetworkQueue.instance.add(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenericRequestObject &&
          runtimeType == other.runtimeType &&
          id == other.id;

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
