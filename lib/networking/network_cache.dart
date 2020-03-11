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
    FileInfo cached = await cache.getFileFromCache(options.optimizedKey);
    return cached != null;
  }

  Future<dynamic> read<ResponseType>({
    Uri uri,
    bool isParse,
    NetworkLearning learning,
    NetworkListener listener,
    ResponseType type,
  }) async {
    DefaultCacheManager cache = DefaultCacheManager();
    FileInfo cached = await cache.getFileFromCache(options.optimizedKey);
    if (cached != null) {
      ResultModel model = ResultModel();
      model.result = options.encrypted ? _decryptAsString(cached.file.readAsStringSync()) : cached.file.readAsStringSync();
      model.bodyBytes = options.encrypted ? _decrypt(cached.file.readAsStringSync()) : cached.file.readAsBytesSync();
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
    Uint8List bytes,
    Duration duration,
  }) async {
    final Uint8List data = options.encrypted ? _encrypt(bytes) : bytes;

    DefaultCacheManager cache = DefaultCacheManager();
    File cached = await cache.putFile(
      options.optimizedKey,
      data,
      maxAge: duration == null ? const Duration(days: 30) : duration,
    );
  }

  clearAll() {
    DefaultCacheManager cache = DefaultCacheManager();
    cache.emptyCache();
  }

  clear({String key}) {
    DefaultCacheManager cache = DefaultCacheManager();
    cache.removeFile(key);
  }

  Uint8List _encrypt(List<int> bytes) {
    var encoded = base64Encode(bytes);
    var encodedBytes = utf8.encode(encoded);
    return Uint8List.fromList(encodedBytes);
  }

  Uint8List _decrypt(String data) {
    Uint8List decoded = base64Decode(data);
    return decoded;
  }

  String _decryptAsString(String data) {
    Uint8List decoded = base64Decode(data);
    return String.fromCharCodes(decoded);
  }
}
