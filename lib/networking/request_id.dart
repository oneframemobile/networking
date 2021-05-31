import 'dart:math';

class RequestId {
  _GUID? _guid;

  RequestId() {
    _guid = new _GUID();
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestId && runtimeType == other.runtimeType && _guid == other._guid;

  @override
  int get hashCode => _guid.hashCode;
}

class _GUID {
  static final Random _random = Random();
  String? value;

  _GUID() {
    value = _generateV4();
  }

  static String _generateV4() {
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  static String _bitsDigits(int bitCount, int digitCount) => _printDigits(_generateBits(bitCount), digitCount);

  static int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  static String _printDigits(int value, int count) => value.toRadixString(16).padLeft(count, '0');

  @override
  bool operator ==(Object other) => identical(this, other) || other is _GUID && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
