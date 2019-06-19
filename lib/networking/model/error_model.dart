import '../generic_request_object.dart';

class ErrorModel<T> {
  T data;
  String description;
  int statusCode;
  String raw;
  NetworkErrorTypes type;

  ErrorModel();
}
