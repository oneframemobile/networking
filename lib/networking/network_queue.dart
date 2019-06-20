import 'dart:collection';
import 'generic_request_object.dart';

class NetworkQueue {
  Queue<GenericRequestObject> _queue;
  bool _isRunning;

  NetworkQueue() {
    _queue = new Queue();
  }

  void start() async {
    _isRunning = true;

    while (true && _isRunning) {
      if (_queue.isNotEmpty) {
        var request = _queue.removeFirst();
        request.fetch();
      }
    }
  }

  void stop() {
    _isRunning = false;
    _queue.clear();
  }

  void add(GenericRequestObject request) {
    _queue.add(request);
  }

  bool cancel(GenericRequestObject request) {
    return _queue.remove(request);
  }

  void clear() {
    _queue.clear();
  }
}
