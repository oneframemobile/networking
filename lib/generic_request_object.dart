import 'dart:convert';
import 'dart:io';

import 'package:networking/model/result_model.dart';
import 'package:networking/network_config.dart';
import 'package:networking/network_learning.dart';
import 'package:networking/network_listener.dart';
import 'package:networking/serializable.dart';
import 'package:networking/header.dart';

class GenericRequestObject<RequestType extends Serializable, ResponseType extends Serializable> {
  List<Header> _headers;
  MethodType _methodType;
  Uri _uri;
  NetworkListener<ResponseType, Serializable> _listener;
  NetworkLearning _learning;
  HttpClient _client;
  NetworkConfig _config;
  Serializable<RequestType> _body;
  ResponseType _instance;

  GenericRequestObject(
    this._methodType,
    this._learning,
    this._client,
    this._config, [
    this._body,
  ]) {
    _headers = [];
  }

  GenericRequestObject url(String url) {
    _uri = Uri.parse(url);
    return this;
  }

  GenericRequestObject addHeaders(Iterable<Header> iterable) {
    _headers.addAll(iterable);
    return this;
  }

  GenericRequestObject addHeader(Header header) {
    _headers.add(header);
    return this;
  }

  GenericRequestObject addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  GenericRequestObject listener(NetworkListener listener) {
    _listener = listener;
    return this;
  }

  GenericRequestObject instance(ResponseType instance) {
    _instance = instance;
    return this;
  }

  void run() {
    _client.postUrl(_uri).then((request) {
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
          var map = json.encode(_body.toJson());
          request.write(map);
        }
      }

      return request.close();
    }).then((response) {
      response.transform(Utf8Decoder()).listen((source) {
        var map = json.decode(source);
        ResultModel<ResponseType> model = new ResultModel();
        model.data = (ResponseType as Serializable).fromJson(map);
        if (_listener != null) {
          _listener.result(model);
        }
      });
    });
  }

  void fetch() async {
    var request = await _client.postUrl(_uri);
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
        var map = json.encode(_body.toJson());
        request.write(map);
      }
    }

    var response = await request.close();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      response.transform(Utf8Decoder()).listen((source) {
        var map = json.decode(source);
        ResultModel<ResponseType> model = new ResultModel<ResponseType>();
        model.data = (_instance as Serializable).fromJson(map);
        if (_listener != null) {
          _listener.result(model);
        }
      });
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
