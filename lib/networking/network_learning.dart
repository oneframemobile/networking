import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_listener.dart';

abstract class NetworkLearning {
  void checkCustomError(NetworkListener listener, ErrorModel error);

  void checkSuccess(NetworkListener listener, ResultModel result);

  void sendSuccess(NetworkListener listener, ResultModel result) {
    listener.result(result);
  }

  void sendError(NetworkListener listener, ErrorModel error) {
    listener.error(error);
  }
}
