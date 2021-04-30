import 'dart:io';

import 'generic_request_object.dart';
import 'header.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'serializable.dart';

class NetworkManager {
  HttpClient client;
  NetworkLearning learning;
  NetworkConfig config;

  NetworkManager({
    this.client,
    this.learning,
    this.config,
  });

  GenericRequestObject<Null, ResponseType, ErrorType> get<ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    ResponseType type,
    ErrorType errorType,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
    bool asList = false,
  }) {
    return GenericRequestObject<Null, ResponseType, ErrorType>(MethodType.GET, learning, config)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse)
        .asList(asList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> post<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    ErrorType errorType,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
    bool isList = false,
  }) {
    return GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.POST, learning, config, body)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse)
        .asList(isList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> put<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    ErrorType errorType,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
    bool isList = false,
  }) {
    return GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.PUT, learning, config, body)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .asList(isList)
        .isParse(isParse);
  }

  GenericRequestObject<Null, ResponseType, ErrorType> delete<ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    ResponseType type,
    ErrorType errorType,
    NetworkListener listener,
    Iterable<Header> headers,
    Duration timeout,
    bool isList = false,
    bool isParse = false,
  }) {
    return GenericRequestObject<Null, ResponseType, ErrorType>(MethodType.DELETE, learning, config)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener)
        .addHeaders(headers)
        .timeout(timeout)
        .asList(isList)
        .isParse(isParse);
  }
}
