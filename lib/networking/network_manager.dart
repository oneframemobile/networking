import 'dart:io';
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

  GenericRequestObject<Null, ResponseType, ErrorType> get<ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    ResponseType type,
    ErrorType error,
    NetworkListener<ResponseType, ErrorType> listener,
    ContentType contentType,
    Iterable<Header> headers,
    bool asList = false,
  }) {
    return new GenericRequestObject<Null, ResponseType, ErrorType>(MethodType.GET, learning, client, config)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .asList(asList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> post<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    ErrorType error,
    NetworkListener<ResponseType, ErrorType> listener,
    ContentType contentType,
    Iterable<Header> headers,
    bool isList = false,
  }) {
    return new GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.POST, learning, client, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .asList(isList);
  }

  GenericRequestObject<RequestType, ResponseType, ErrorType> put<RequestType extends Serializable, ResponseType extends Serializable, ErrorType extends Serializable>({
    String url,
    dynamic body,
    ResponseType type,
    ErrorType error,
    NetworkListener<ResponseType, ErrorType> listener,
    ContentType contentType,
    Iterable<Header> headers,
    bool isList = false,
  }) {
    return new GenericRequestObject<RequestType, ResponseType, ErrorType>(MethodType.PUT, learning, client, config, body)
        .url(url)
        .type(type)
        .listener(listener)
        .contentType(contentType)
        .addHeaders(headers)
        .asList(isList);
  }
}
