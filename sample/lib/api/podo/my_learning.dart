import 'package:networking/networking.dart';

class MyLearning extends NetworkLearning {
  @override
  void checkCustomError(NetworkListener listener, ErrorModel error) {
    // TODO: implement checkCustomError
  }

  @override
  void checkSuccess(NetworkListener listener, ResultModel result) {
    try {
      var data = result.data as dynamic;
      if (data.errorMessage == null) {
        sendSuccess(listener, result as dynamic);
      } else {
        ErrorModel<String> error = new ErrorModel();
        error.description = "Hata!";
        sendError(listener, error);
      }
    } on NoSuchMethodError catch (e) {
      print(e.toString());
    }
  }
}
