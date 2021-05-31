class NetworkCacheOptions {
  String? key;
  bool enabled = false;
  bool recoverFromException = false;
  bool encrypted = false;
  Duration? duration = Duration(days: 30);

  String get optimizedKey => "$key${encrypted ? "encrypted" : ""}";

  NetworkCacheOptions({
    this.key,
    this.enabled = false,
    this.duration,
    this.recoverFromException = false,
    this.encrypted = false
  });
}
