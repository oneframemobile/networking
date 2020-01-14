import 'package:networking/networking.dart';

class MyLearning extends NetworkLearning {
  @override
  checkCustomError(NetworkListener listener, ErrorModel error) {}

  @override
  checkSuccess<T>(NetworkListener listener, ResultModel result) {
    try {
      var data = result.data as dynamic;
      if (data.errorMessage == null) {
        return sendSuccess(listener, result as dynamic);
      } else {
        ErrorModel<String> error = new ErrorModel();
        error.description = "Hata!";
        return sendError(listener, error);
      }
    } on NoSuchMethodError catch (e) {
      ErrorModel<StackTrace> error = new ErrorModel();
      error.data = e.stackTrace;
      return sendError(listener, error);
    }
  }
}
