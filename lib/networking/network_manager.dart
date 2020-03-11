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

  GenericRequestObject<ResponseType> get<ResponseType extends Serializable>({
    String url,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
  }) {
    return GenericRequestObject<ResponseType>(MethodType.GET, learning, config)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<ResponseType> post<RequestType extends Serializable, ResponseType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
  }) {
    return GenericRequestObject<ResponseType>(MethodType.POST, learning, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<ResponseType> put<RequestType extends Serializable, ResponseType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    NetworkListener listener,
    ContentType contentType,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
  }) {
    return GenericRequestObject<ResponseType>(MethodType.PUT, learning, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<ResponseType> delete<RequestType extends Serializable, ResponseType extends Serializable>({
    String url,
    ResponseType type,
    Iterable<Header> headers,
    Duration timeout,
    bool isParse = false,
  }) {
    return GenericRequestObject<ResponseType>(MethodType.DELETE, learning, config).url(url).type(type).addHeaders(headers).timeout(timeout).isParse(isParse);
  }
}
