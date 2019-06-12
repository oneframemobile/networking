import 'package:networking/networking.dart';

class MyLearning extends NetworkLearning<dynamic> {
  @override
  void checkCustomError(NetworkListener listener, ErrorModel error) {
    // TODO: implement checkCustomError
  }

  @override
  void checkSuccess(NetworkListener listener, ResultModel result) {
    try {
      if (result.data.errorMessage == null) {
        sendSuccess(listener, result);
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
