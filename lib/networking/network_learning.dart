import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_listener.dart';

abstract class NetworkLearning {
  checkCustomError(NetworkListener listener, ErrorModel error);

  checkSuccess(NetworkListener listener, ResultModel result);

  sendSuccess(NetworkListener listener, ResultModel result) {
    listener.result(result);
    return Future.value(result);
  }

  sendError(NetworkListener listener, ErrorModel error) {
    listener.error(error);
    return Future.error(error);
  }
}
