import 'dart:io';

import 'dart:typed_data';

class ResultModel<T> {
  late T data;
  late String url;
  late Map<String, dynamic> json;
  late String jsonString;
  late Iterable jsonList;
  late String result;
  late List<Cookie> cookies;
  late Uint8List bodyBytes;

  ResultModel();
}
