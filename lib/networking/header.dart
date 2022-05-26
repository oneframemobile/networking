class Header {
  String key;
  String value;
  bool? preserveHeaderCase = false;
  Header({required this.key, required this.value, this.preserveHeaderCase});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Header && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
