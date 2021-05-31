import 'model/error_model.dart';
import 'model/result_model.dart';

class NetworkListener<R, E> {
  Function(ResultModel<R>)? result;
  Function(ErrorModel<E>)? error;

  NetworkListener();

  NetworkListener<R, E> onSuccess(Null Function(ResultModel<R>) result) {
    this.result = result;
    return this;
  }

  NetworkListener<R, E> onError(Null Function(ErrorModel<E>) error) {
    this.error = error;
    return this;
  }
}
