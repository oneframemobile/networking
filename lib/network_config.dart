import 'package:networking/header.dart';

class NetworkConfig {
  List<Header> _headers = [];
  int _timeout = 60000;
  String _baseUrl;

  NetworkConfig addHeaders(Iterable<Header> iterable) {
    _headers.addAll(iterable);
    return this;
  }

  NetworkConfig addHeader(Header header) {
    _headers.add(header);
    return this;
  }

  NetworkConfig addHeaderWithParameters(String key, String value) {
    var header = new Header(key, value);
    _headers.add(header);
    return this;
  }

  NetworkConfig setTimeout(int timeout) {
    _timeout = timeout;
    return this;
  }

  NetworkConfig setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    return this;
  }

  int get timeout {
    return _timeout;
  }

  List<Header> get headers {
    return _headers;
  }

  String get baseUrl {
    return _baseUrl;
  }
}
