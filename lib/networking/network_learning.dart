import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_listener.dart';

abstract class NetworkLearning<ResponseType> {
  void checkCustomError(NetworkListener<ResponseType, dynamic> listener, ErrorModel error);

  void checkSuccess(NetworkListener<ResponseType, dynamic> listener, ResultModel<ResponseType> result);

  void sendSuccess(NetworkListener<ResponseType, dynamic> listener, ResultModel<ResponseType> result) {
    listener.result(result);
  }

  void sendError(NetworkListener<ResponseType, dynamic> listener, ErrorModel error) {
    listener.error(error);
  }
}
