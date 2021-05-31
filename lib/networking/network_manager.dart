import 'dart:io';

import 'generic_request_object.dart';
import 'header.dart';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_listener.dart';
import 'serializable.dart';

class NetworkManager {
  HttpClient? client;
  NetworkLearning? learning;
  NetworkConfig? config;

  NetworkManager({
    this.client,
    this.learning,
    this.config,
  });

  GenericRequestObject<Serializable<dynamic>, ResponseType, ErrorType> get<ResponseType extends Serializable, ErrorType extends Serializable>({
    required String url,
    required ResponseType type,
    ErrorType? errorType,
    NetworkListener? listener,
    ContentType? contentType,
    Iterable<Header>? headers,
    Duration? timeout,
    bool isParse = false,
    bool asList = false,
  }) {
    return GenericRequestObject<Serializable<dynamic>, ResponseType, ErrorType>(MethodType.GET, learning!, config!)
        .url(url)
        .type(type)
        .errorType(errorType!)
        .listener(listener!)
        .contentType(contentType!)
        .addHeaders(headers!)
        .timeout(timeout!)
        .isParse(isParse)
        .asList(asList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> post<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    required String url,
    dynamic body,
    required ResponseType type,
    ErrorType? errorType,
    NetworkListener? listener,
    ContentType? contentType,
    Iterable<Header>? headers,
    Duration? timeout,
    bool isParse = false,
    bool isList = false,
  }) {
    return GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.POST, learning!, config!, body)
        .url(url)
        .type(type)
        .errorType(errorType!)
        .listener(listener!)
        .contentType(contentType!)
        .addHeaders(headers!)
        .timeout(timeout!)
        .isParse(isParse)
        .asList(isList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> put<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    required String url,
    dynamic body,
    required ResponseType type,
    required ErrorType errorType,
    NetworkListener? listener,
    ContentType? contentType,
    Iterable<Header>? headers,
    Duration? timeout,
    bool isParse = false,
    bool isList = false,
  }) {
    return GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.PUT, learning!, config!, body)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener!)
        .contentType(contentType!)
        .addHeaders(headers!)
        .timeout(timeout!)
        .asList(isList)
        .isParse(isParse);
  }

  GenericRequestObject<Serializable<dynamic>, ResponseType, ErrorType> delete<ResponseType extends Serializable, ErrorType extends Serializable>({
    required String url,
    required ResponseType type,
    required ErrorType errorType,
    NetworkListener? listener,
    Iterable<Header>? headers,
    Duration? timeout,
    bool isList = false,
    bool isParse = false,
  }) {
    return GenericRequestObject<Serializable<dynamic>, ResponseType, ErrorType>(MethodType.DELETE, learning!, config!)
        .url(url)
        .type(type)
        .errorType(errorType)
        .listener(listener!)
        .addHeaders(headers!)
        .timeout(timeout!)
        .asList(isList)
        .isParse(isParse);
  }
}
