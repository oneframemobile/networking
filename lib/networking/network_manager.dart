import 'dart:io';
import 'package:networking/networking/model/result_model.dart';

import 'generic_request_object.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'serializable.dart';
import 'header.dart';

class NetworkManager {
  HttpClient client;
  NetworkLearning learning;
  NetworkConfig config;

  NetworkManager({this.client, this.learning, this.config});

  GenericRequestObject<Null, ResponseType, ErrorType>
      get<ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool asList = false,
  }) {
    return new GenericRequestObject<Null, ResponseType, ErrorType>(
            MethodType.GET, learning, client, config)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .asList(asList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType > post<
      RequestType extends Serializable,
      ResponseType extends Serializable,
      ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isList = false,
  }) {
    return new GenericRequestObject<RequestType, ResponseType, ErrorType>(
            MethodType.POST, learning, client, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .asList(isList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> put<
      RequestType extends Serializable,
      ResponseType extends Serializable,
      ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isList = false,
  }) {
    return new GenericRequestObject<RequestType, ResponseType, ErrorType>(
            MethodType.PUT, learning, client, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .asList(isList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType > delete<
      RequestType extends Serializable,
      ResponseType extends Serializable,
      ErrorType extends Serializable>({
    String url,
    ResponseType type,
    Iterable<Header> headers,
    Duration timeout,
  }) {
    return new GenericRequestObject<RequestType, ResponseType, ErrorType>(
            MethodType.DELETE, learning, client, config)
        .url(url)
        .type(type)
        .addHeaders(headers)
        .timeout(timeout);
  }
}
