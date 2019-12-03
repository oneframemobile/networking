class Header {
  String key;
  String value;

  Header(this.key, this.value);

  @override
  bool operator ==(Object other) => identical(this, other) || other is Header && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
