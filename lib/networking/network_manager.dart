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

  NetworkManager({this.client, this.learning, this.config});

  GenericRequestObject<Null, ResponseType>
      get<ResponseType extends Serializable>(
          {String url,
          ResponseType type,
          NetworkListener listener,
          ContentType contentType,
          Iterable<Header> headers,
          Duration timeout,
          bool isParse = false}) {
    return GenericRequestObject<Null, ResponseType>(
            MethodType.GET, learning, config)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<RequestType, ResponseType>
      post<RequestType extends Serializable, ResponseType extends Serializable>(
          {String url,
          dynamic body,
          ResponseType type,
          NetworkListener listener,
          ContentType contentType,
          Iterable<Header> headers,
          Duration timeout,
          bool isParse = false}) {
    return GenericRequestObject<RequestType, ResponseType>(
            MethodType.POST, learning, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<RequestType, ResponseType>
      put<RequestType extends Serializable, ResponseType extends Serializable>(
          {String url,
          dynamic body,
          ResponseType type,
          NetworkListener listener,
          ContentType contentType,
          Iterable<Header> headers,
          Duration timeout,
          bool isParse = false}) {
    return GenericRequestObject<RequestType, ResponseType>(
            MethodType.PUT, learning, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }

  GenericRequestObject<RequestType, ResponseType> delete<
          RequestType extends Serializable, ResponseType extends Serializable>(
      {String url,
      ResponseType type,
      Iterable<Header> headers,
      Duration timeout,
      bool isParse = false}) {
    return GenericRequestObject<RequestType, ResponseType>(
            MethodType.DELETE, learning, config)
        .url(url)
        .type(type)
        .addHeaders(headers)
        .timeout(timeout)
        .isParse(isParse);
  }
}
