import 'dart:async';

import 'generic_request_object.dart';

class NetworkQueue {
  static final NetworkQueue instance = NetworkQueue._internal();

  StreamController<GenericRequestObject> _queue;
  bool _isRunning;

  NetworkQueue._internal() {
    _queue = new StreamController();
    _isRunning = false;
  }

  void start() {
    if (_isRunning) {
      return;
    }

    _isRunning = true;

    _queue.stream.listen((request) async {
      await request.fetch();
    });
  }

  void stop() {
    _isRunning = false;
    _queue.close();
  }

  void add(GenericRequestObject request) {
    _queue.sink.add(request);
  }
}
