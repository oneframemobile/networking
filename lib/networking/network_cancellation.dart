import 'package:networking/networking.dart';

class NetworkCancellation {
  static NetworkCancellation? _instance;
  final Set<GenericRequestObject> _calls = Set();

  NetworkCancellation._internal();

  static NetworkCancellation getInstance() {
    if (_instance == null) {
      _instance = NetworkCancellation._internal();
    }

    return _instance!;
  }

  void cancel({required String tag}) => _calls.where((element) => element.isTag(tag)).toList().forEach((element) => element.cancel());

  void cancelAll() => _calls.toList().forEach((element) => element.cancel());

  void add(GenericRequestObject object) => _calls.add(object);

  void remove(GenericRequestObject object) => _calls.removeWhere((element) => element == object);
}
