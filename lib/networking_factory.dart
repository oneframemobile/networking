import 'dart:io';
import 'package:networking/network_config.dart';
import 'package:networking/network_learning.dart';
import 'package:networking/network_manager.dart';

class NetworkingFactory {
  static NetworkManager create({
    HttpClient client,
    NetworkLearning learning,
    NetworkConfig config,
  }) {
    return new NetworkManager(
      client: client == null ? new HttpClient() : client,
      learning: learning,
      config: config,
    );
  }
}
