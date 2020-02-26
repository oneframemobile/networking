import 'dart:convert';
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:networking/networking.dart';

class NetworkCache {
  Future<dynamic> read<ResponseType>({
    String key,
    Uri uri,
    bool isParse,
    NetworkLearning learning,
    NetworkListener listener,
    ResponseType type,
  }) async {
    DefaultCacheManager cache = DefaultCacheManager();
    File cached = await cache.getSingleFile(key);
    if (cached != null) {
      ResultModel model = ResultModel();
      model.result = cached.readAsStringSync();
      model.bodyBytes = cached.readAsBytesSync();
      model.json = json.decode(model.result);
      model.url = uri.toString();

      if (isParse) {
        return learning.checkSuccess<ResponseType>(listener, model);
      }

      var serializable = (type as SerializableObject);
      dynamic body = model.json;
      if (body is List)
        model.data = body.map((data) => serializable.fromJson(data)).cast<ResponseType>().toList();
      else if (body is Map)
        model.data = serializable.fromJson(body) as ResponseType;
      else
        model.data = body;

      if (learning != null)
        return learning.checkSuccess<ResponseType>(listener, model);
      else {
        listener?.result(model);
        return model;
      }
    }
  }
}
