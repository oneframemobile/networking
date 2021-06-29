import 'dart:io';

import 'dart:typed_data';

class ResultModel<T> {
  T? data;
  String? url;
  Map<String, dynamic>? json;
  String? jsonString;
  Iterable? jsonList;
  String? result;
  List<Cookie>? cookies;
  Uint8List? bodyBytes;

  ResultModel();
}
