import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:networking/networking.dart';
import 'package:networking/networking/model/network_cache_options.dart';

class NetworkCache {
  NetworkCacheOptions options;

  NetworkCache() {
    options = NetworkCacheOptions();
  }

  Future<bool> has() async {
    DefaultCacheManager cache = DefaultCacheManager();
    FileInfo cached = await cache.getFileFromCache(options.key);
    return cached != null;
  }

  Future<dynamic> read<ResponseType>({
    String key,
    Uri uri,
    bool isParse,
    NetworkLearning learning,
    NetworkListener listener,
    ResponseType type,
  }) async {
    DefaultCacheManager cache = DefaultCacheManager();
    FileInfo cached = await cache.getFileFromCache(key);
    if (cached != null) {
      ResultModel model = ResultModel();
      model.result = cached.file.readAsStringSync();
      model.bodyBytes = cached.file.readAsBytesSync();
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

  Future<dynamic> save({
    String key,
    Uint8List bytes,
    Duration duration,
  }) async {
    DefaultCacheManager cache = DefaultCacheManager();
    File cached = await cache.putFile(
      key,
      bytes,
      maxAge: duration == null ? const Duration(days: 30) : duration,
    );
  }

  clear() {
    DefaultCacheManager cache = DefaultCacheManager();
    cache.emptyCache();
  }
}
