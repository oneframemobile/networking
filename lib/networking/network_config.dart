import 'header.dart';

class NetworkConfig {
  Set<Header> _headers = new Set();
  Duration _timeout = new Duration(seconds: 60);
  List<int> _successStatusCode = [];

  late String _baseUrl;
  String? _parseKey;

  NetworkConfig addHeaders(Iterable<Header> iterable) {
    _headers.addAll(iterable);
    return this;
  }

  NetworkConfig addSuccessCodes(int startCode, int endCode) {
    for (int i = startCode; i < endCode; i++) {
      _successStatusCode.add(i);
    }
    return this;
  }

  NetworkConfig addHeader(Header header) {
    _headers.add(header);
    return this;
  }

  NetworkConfig addHeaderWithParameters(String key, String value) {
    var header = new Header(key: key, value: value);
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

  NetworkConfig setParseKey(String parseKey) {
    _parseKey = parseKey;
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

  String? get parseKey {
    return _parseKey;
  }

  List<int> get successStatusCode {
    return _successStatusCode;
  }
}
