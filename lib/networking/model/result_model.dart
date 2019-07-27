import 'dart:io';

class ResultModel<T> {
  T data;
  String url;
  Map<String, dynamic> json;
  Iterable jsonList;
  String result;
  List<Cookie> cookies;

  ResultModel();
}
