import '../generic_request_object.dart';

class ErrorModel<T> {
  T data;
  String description;
  int errorCode;
  NetworkErrorTypes type;

  ErrorModel();
}
