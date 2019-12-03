import 'dart:io';
import 'package:networking/networking/network_queue.dart';

import 'network_config.dart';
import 'network_learning.dart';
import 'network_manager.dart';

class NetworkingFactory {
  static void init() {
    NetworkQueue.instance.start();
  }

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
