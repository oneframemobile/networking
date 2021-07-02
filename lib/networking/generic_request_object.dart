import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:networking/networking/model/network_cache_options.dart';
import 'package:networking/networking/network_cache.dart';

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

class GenericRequestObject<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable> {
  Set<Header>? _headers;
  ContentType? _contentType;
  MethodType? _methodType;
  Duration? _timeout;
  Uri? _uri;
  NetworkLearning? _learning;
  NetworkConfig? _config;
  NetworkListener? _listener;
  dynamic _body;
  ResponseType? _type;
  ErrorType? _errorType;
  Set<Cookie>? _cookies;
  bool? _isParse;
  String? body;
  NetworkCache? _cache;

  final RequestId id = new RequestId();

  bool? _asList;
  String? _parseKey;

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

  GenericRequestObject<RequestType, ResponseType, ErrorType> url(String url) {
    _uri = Uri.parse(_config != null ? _config!.baseUrl + url : url);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> asList(bool asList) {
    _asList = asList;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> parseKey(String parseKey) {
    _parseKey = parseKey;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaders(Iterable<Header>? headers) {
    if (headers != null) {
      _headers?.addAll(headers);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> errorType(ErrorType? type) {
    _errorType = type;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeader(Header? header) {
    if (_headers != null && header != null) {
      /// check same headers value. if some value income remove older value and update [header]
      if (_headers!.contains(header)) {
        _headers?.removeWhere((header) => header.key == header.key);
        print(_headers?.length);
        _headers?.add(header);
      } else {
        _headers?.add(header);
      }
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addCookies(Iterable<Cookie>? cookies) {
    if (cookies != null && _cookies != null) {
      _cookies!.addAll(cookies);
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addCookie(Cookie? cookie) {
    if (cookie != null && _cookies != null) {
      _cookies!.add(cookie);
    }
    return this;
  }

  @Deprecated("Use query instead")
  GenericRequestObject<RequestType, ResponseType, ErrorType> addQuery(String key, String value) {
    if (_uri.toString().contains("?")) {
      _uri = Uri.parse(_uri.toString() + "&$key=$value");
    } else {
      _uri = Uri.parse(_uri.toString() + "?$key=$value");
    }
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers?.add(header);
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> contentType(ContentType? contentType) {
    _contentType = contentType;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> timeout(Duration? timeout) {
    if (timeout != null) _timeout = timeout;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> isParse(bool isParse) {
    _isParse = isParse;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> listener(NetworkListener? listener) {
    _listener = listener;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> type(ResponseType type) {
    _type = type;
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> query(String key, String value) {
    var old = _uri.toString();
    var prefix = old.contains("?") ? "&" : "?";
    _uri = Uri.parse("$old$prefix$key=$value");
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> path(String path) {
    _uri = Uri.parse(_uri.toString() + "/$path");
    return this;
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> cache({
    bool enabled = false,
    required String key,
    Duration? duration,
    bool recoverFromException = false,
    bool encrypted = false,
  }) {
    _cache = NetworkCache();
    _cache!.options = NetworkCacheOptions(
      enabled: enabled,
      key: key,
      duration: duration,
      recoverFromException: recoverFromException,
      encrypted: encrypted,
    );

    return this;
  }

  Future<HttpClientRequest> _request() async {
    final client = HttpClient();
    client.connectionTimeout = _config == null ? Duration(minutes: 1) : _config!.timeout;
    if (_uri != null) {
      switch (_methodType!) {
        case MethodType.GET:
          return await client.getUrl(_uri!);
        case MethodType.POST:
          return await client.postUrl(_uri!);
        case MethodType.PUT:
          return await client.putUrl(_uri!);
        case MethodType.DELETE:
          return await client.deleteUrl(_uri!);
        case MethodType.UPDATE:
          return await client.patchUrl(_uri!);
      }
    }

    throw new Exception("Unknown method type.");
  }

  Future<dynamic> fetch() async {
    var request = await _request();
    try {
      _cookies?.forEach((cookie) => request.cookies.add(cookie));
      if (_headers != null) {
        _headers?.forEach((header) => request.headers.add(header.key, header.value));
      }

      if (_methodType == MethodType.POST || _methodType == MethodType.PUT) {
        request.headers.add(
          HttpHeaders.contentTypeHeader,
          _contentType == null ? ContentType.json.toString() : _contentType.toString(),
        );
        if (_body != null && body == null) {
          var model = json.encode(_body);
          var utf8Length = utf8.encode(model).length;

          request.headers.contentLength = utf8Length;

          if (_body is List) {
            if (_body.first is SerializableObject) {
              var mapList = _body.map((SerializableObject item) => item.toJson()).toList();
              var jsonMapList = json.encode(mapList);
              request.write(jsonMapList);
              body = jsonMapList;
            } else {
              throw ErrorDescription("Body list param does not have serializable object");
            }
          } else {
            body = model;
            request.write(body);
          }
        } else if (body != null && body!.isNotEmpty) {
          request.headers.contentLength = utf8.encode(body!).length;
          request.write(body);
        }
      }

      if (_uri != null && _cache != null && _isParse != null && _cache!.options.enabled && await _cache!.has()) {
        return _cache!.read<ResponseType>(
          uri: _uri!,
          isParse: _isParse!,
          learning: _learning,
          listener: _listener,
          type: _type,
        );
      }

      var response = await request.close().timeout(
        (_config != null
            ? _config!.timeout
            : _timeout == null
                ? Duration(minutes: 1)
                : _timeout)!,
        onTimeout: () {
          throw TimeoutException("Timeout");
        },
      );

      var buffer = new StringBuffer();
      var bytes = await consolidateHttpClientResponseBytes(response);

      if (_config != null && _config!.successStatusCode.length > 0 && _config!.successStatusCode.indexOf(response.statusCode) > -1) {
        ResultModel model = ResultModel();
        model.url = _uri.toString();

        if (response.cookies != null) {
          model.cookies = response.cookies;
        }

        try {
          model.result = utf8.decode(bytes);
          if (_isParse != null && _isParse!) {
            await request.done;
            return _learning?.checkSuccess<ResponseType>(_listener!, model);
          }

          buffer.write(String.fromCharCodes(bytes));

          if (buffer.isNotEmpty) {
            var body = json.decode(model.result ?? "");

            if (_cache != null && _cache!.options.enabled) {
              _cache!.save(bytes: bytes, duration: _cache!.options.duration);
            }

            if (_asList != null && !_asList!) {
              //var map = json.decode(body);
              var serializable = (_type as SerializableObject);
              model.data = serializable.fromJson(body);
              model.json = body;
            } else {
              Iterable iterable;
              if (_parseKey != null) {
                iterable = json.decode(buffer.toString())[_parseKey];
              } else {
                iterable = json.decode(buffer.toString());
              }

              var serializable = (_type as SerializableList);
              serializable.list = serializable.fromJsonList(iterable.toList());
              model.data = _type;
              model.jsonList = iterable;
            }
          }
        } catch (e) {
          String s = String.fromCharCodes(bytes);
          model.bodyBytes = new Uint8List.fromList(s.codeUnits);
          model.result = "";
          print(e);
        }

        await request.done;
        if (_learning != null)
          return _learning!.checkSuccess<ResponseType>(_listener!, model);
        else {
          //_listener?.result!(model);
          return model;
        }
      } else {
        buffer.write(String.fromCharCodes(bytes));
        utf8.decode(bytes);
        await request.done;
        ErrorModel error = ErrorModel();
        error.description = response.reasonPhrase;
        error.statusCode = response.statusCode;
        error.raw = buffer.toString();
        if (buffer.isNotEmpty || buffer.toString().contains(":")) {
          try {
            var errorMap = json.decode(buffer.toString());
            var serializable = (_errorType as SerializableObject);
            error.data = serializable.fromJson(errorMap);
          } catch (e) {
            error.data = null;
          }
        }

        error.request = this;

        if (_learning != null)
          return _learning!.checkCustomError(_listener!, error);
        else
          return error;
      }
    } on SocketException catch (exception) {
      if (_cache != null && _cache!.options.enabled && _cache!.options.recoverFromException) {
        return _cache!.read<ResponseType>(
          uri: _uri!,
          isParse: _isParse!,
          learning: _learning,
          listener: _listener,
          type: _type,
        );
      }

      return customErrorHandler(exception, NetworkErrorTypes.NETWORK_ERROR, request: request);
    } on TimeoutException catch (exception) {
      return customErrorHandler(exception, NetworkErrorTypes.TIMEOUT_ERROR, request: request);
    } catch (exception) {
      return customErrorHandler(exception, NetworkErrorTypes.TIMEOUT_ERROR, request: request);
    }
  }

  List fromJsonList(List json, dynamic model) {
    return json.map((fields) => model.fromJson(fields)).cast<ResponseType>().toList();
  }

  Future<void> customErrorHandler(exception, NetworkErrorTypes types, {HttpClientRequest? request}) async {
    await request?.done;
    ErrorModel error = ErrorModel();
    error.description = exception.message;
    error.type = types;
    error.request = this;

    _listener?.error!(error);

    if (_learning != null)
      return await _learning!.checkCustomError(_listener!, error);
    else
      throw (error);
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
