import 'package:networking/networking/network_manager.dart';
import 'package:networking/networking/networking_factory.dart';
import 'package:networking/networking.dart';

class ApiManager {
  NetworkManager _manager;

  static final ApiManager instance = new ApiManager._apiManager();
  ApiManager._apiManager() {
    NetworkConfig _config = NetworkConfig();
    _config.setBaseUrl("https://hwasampleapi.firebaseio.com/");
    if (_manager == null) _manager = NetworkingFactory.create(config: _config);
  }
  static ApiManager get getInstance => instance;

  Future deleteFirebaseChild({String child}) async {
    try {
      final response = await _manager.delete(url: "$child.json").fetch();
      return response;
    } catch (e) {
      print(e);
    }
  }
}
