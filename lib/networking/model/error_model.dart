import '../generic_request_object.dart';

class ErrorModel<T> {
  late T data;
  late String description;
  late int statusCode;
  late String raw;
  late NetworkErrorTypes type;
  late GenericRequestObject request;

  ErrorModel();
}
