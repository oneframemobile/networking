import 'header.dart';

class NetworkConfig {
  Set<Header> _headers = new Set();
  Duration _timeout = new Duration(seconds: 60);
  List<int> _successStatusCode = [];
  bool _isEnableLog = false;

  late String _baseUrl;
  Set<String> _parseKeys = new Set();

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

  NetworkConfig setEnableLog(bool isEnableLog) {
    _isEnableLog = isEnableLog;
    return this;
  }

  NetworkConfig setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    return this;
  }

  NetworkConfig setParseKey(List<String> parseKeys) {
    _parseKeys = new Set();
    _parseKeys.addAll(parseKeys);
    return this;
  }

  Duration get timeout {
    return _timeout;
  }

  bool get isEnableLog {
    return _isEnableLog;
  }

  Set<Header> get headers {
    return _headers;
  }

  String get baseUrl {
    return _baseUrl;
  }

  Set<String> get parseKeys {
    return _parseKeys;
  }

  List<int> get successStatusCode {
    return _successStatusCode;
  }
}
