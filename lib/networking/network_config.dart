import 'header.dart';

class NetworkConfig {
  Set<Header> _headers = new Set();
  Duration _timeout = new Duration(seconds: 60);
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

  NetworkConfig setTimeout(Duration timeout) {
    _timeout = timeout;
    return this;
  }

  NetworkConfig setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    return this;
  }

  Duration get timeout {
    return _timeout;
  }

  Set<Header> get headers {
    return _headers;
  }

  String get baseUrl {
    return _baseUrl;
  }
}
