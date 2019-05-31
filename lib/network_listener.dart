import 'package:networking/model/error_model.dart';
import 'package:networking/model/result_model.dart';
import 'package:networking/serializable.dart';

class NetworkListener<R extends Serializable, E extends Serializable> {
  Function(ResultModel<R>) _result;
  Function(ErrorModel<E>) _error;

  NetworkListener();

  NetworkListener<R, E> onSuccess(Function(ResultModel<R>) result) {
    return this;
  }

  NetworkListener<R, E> onError(Function(ErrorModel<E>) error) {
    this._error = error;
    return this;
  }

  Function(ResultModel<R>) get result {
    return _result;
  }

  Function(ErrorModel<E>) get error {
    return _error;
  }
}
