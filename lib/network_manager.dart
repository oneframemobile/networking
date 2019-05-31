import 'dart:io';

import 'package:networking/generic_request_object.dart';
import 'package:networking/network_config.dart';
import 'package:networking/network_learning.dart';
import 'package:networking/network_listener.dart';
import 'package:networking/serializable.dart';

class NetworkManager {
  HttpClient client;
  NetworkLearning learning;
  NetworkConfig config;

  NetworkManager({this.client, this.learning, this.config});

  GenericRequestObject get(
    String url,
    NetworkListener listener,
  ) {
    return new GenericRequestObject(MethodType.GET, learning, client, config)
        .url(url)
        .listener(listener);
  }

  GenericRequestObject<RequestType, ResponseType> post<RequestType extends Serializable, ResponseType extends Serializable>({
    String url,
    dynamic body,
    ResponseType instance,
    NetworkListener<ResponseType, Serializable> listener,
  }) {
    return new GenericRequestObject<RequestType, ResponseType>(
            MethodType.POST, learning, client, config, body)
        .url(url)
        .instance(instance)
        .listener(listener);
  }
}
