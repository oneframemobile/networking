import 'model/error_model.dart';
import 'model/result_model.dart';
import 'network_listener.dart';

abstract class NetworkLearning {
  checkCustomError(NetworkListener listener, ErrorModel error);

  checkSuccess<T>(NetworkListener listener, ResultModel result);

  sendSuccess(NetworkListener listener, ResultModel result) {
    listener.result(result);
    return result;
  }

  sendError(NetworkListener listener, ErrorModel error) {
    if(listener != null)
    listener.error(error);



    //return error;
    //throw error;
  }
}
