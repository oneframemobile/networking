import 'dart:io';
import 'network_config.dart';
import 'network_learning.dart';
import 'network_manager.dart';

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
