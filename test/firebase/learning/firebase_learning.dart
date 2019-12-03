import 'dart:io';

import 'package:networking/networking/model/error_model.dart';
import 'package:networking/networking/model/result_model.dart';
import 'package:networking/networking/network_learning.dart';
import 'package:networking/networking/network_listener.dart';

class FirebaseLearning extends NetworkLearning {
  @override
  checkCustomError(NetworkListener listener, ErrorModel error) async {
    await error.request.fetch();
    return null;
  }

  @override
  checkSuccess(NetworkListener listener, ResultModel result) {
    print(result.data);

    return result;
  }
}
