import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'header.dart';
import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'network_queue.dart';
import 'request_id.dart';
import 'serializable.dart';
import 'serializable_object.dart';

class GenericRequestObject<ResponseType extends Serializable> {
  Set<Header> _headers;
  ContentType _contentType;
  MethodType _methodType;
  Duration _timeout;
  Uri _uri;
  NetworkLearning _learning;
  NetworkConfig _config;
  NetworkListener _listener;
  dynamic _body;
  ResponseType _type;
  Set<Cookie> _cookies;
  bool _isParse;

  final RequestId id = new RequestId();

  GenericRequestObject(
    this._methodType,
    this._learning,
    this._config, [
    this._body,
  ]) {
    _headers = new Set();
    _cookies = new Set();
    _timeout = Duration(seconds: 60);
    _isParse = false;
  }

  GenericRequestObject<ResponseType> url(String url) {
    _uri = Uri.parse(_config != null ? _config.baseUrl + url : url);
    return this;
  }

  GenericRequestObject<ResponseType> addHeaders(Iterable<Header> headers) {
    if (headers != null) {
      _headers.addAll(headers);
    }
    return this;
  }

  GenericRequestObject<ResponseType> addHeader(Header header) {
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

  GenericRequestObject<ResponseType> addCookies(Iterable<Cookie> cookies) {
    if (cookies != null) {
      _cookies.addAll(cookies);
    }
    return this;
  }

  GenericRequestObject<ResponseType> addCookie(Cookie cookie) {
    if (cookie != null) {
      _cookies.add(cookie);
    }
    return this;
  }

  GenericRequestObject<ResponseType> addQuery(String key, String value) {
    if (_uri.toString().contains("?")) {
      _uri = Uri.parse(_uri.toString() + "&$key=$value");
    } else {
      _uri = Uri.parse(_uri.toString() + "?$key=$value");
    }
    return this;
  }

  GenericRequestObject<ResponseType> addHeaderWithParameters(
      String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  GenericRequestObject<ResponseType> contentType(ContentType contentType) {
    _contentType = contentType;
    return this;
  }

  GenericRequestObject<ResponseType> timeout(Duration timeout) {
    _timeout = timeout;
    return this;
  }

  GenericRequestObject<ResponseType> isParse(bool isParse) {
    _isParse = isParse;
    return this;
  }

  GenericRequestObject<ResponseType> listener(NetworkListener listener) {
    _listener = listener;
    return this;
  }

  GenericRequestObject<ResponseType> type(ResponseType type) {
    _type = type;
    return this;
  }

  GenericRequestObject<ResponseType> query(String key, String value) {
    _uri = Uri.parse(_uri.toString() + "?$key=$value");
    return this;
  }

  GenericRequestObject<ResponseType> path(String path) {
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
          // request body parser
          if (_body is List) {
            if (_body.first is SerializableObject) {
              var mapList = _body
                  .map((SerializableObject item) => item.toJson())
                  .toList();
              var jsonMapList = json.encode(mapList);
              request.write(jsonMapList);
            } else {
              throw ErrorDescription(
                  "Body list param does not have serializable object");
            }
          } else if (_body is SerializableObject) {
            SerializableObject serializable = _body as SerializableObject;
            var map = json.encode(serializable.toJson());
            request.write(map);
          } else {
            request.write(json.encode(_body));
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

        if (_isParse) {
          await request.done;
          return _learning.checkSuccess<ResponseType>(_listener, model);
        }

        // check empty or return single value
        if (buffer.isNotEmpty) {
          var body = json.decode(buffer.toString());
          model.jsonString = buffer.toString();
          var serializable = (_type as SerializableObject);

          if (body is List)
            model.data = body
                .map((data) => serializable.fromJson(data))
                .cast<ResponseType>()
                .toList();
          else if (body is Map)
            model.data = serializable.fromJson(body) as ResponseType;
          else
            model.data = body;
        }

        await request.done;
        if (_learning != null)
          return _learning.checkSuccess<ResponseType>(_listener, model);
        else {
          _listener?.result(model);
          return model;
        }
      } else {
        ErrorModel error = ErrorModel();
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
    ErrorModel error = ErrorModel();
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
