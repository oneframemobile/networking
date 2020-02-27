class NetworkCacheOptions {
  String key;
  bool enabled = false;
  bool recoverFromException = false;
  Duration duration = Duration(days: 30);

  NetworkCacheOptions({
    this.key,
    this.enabled,
    this.duration,
    this.recoverFromException,
  });
}
