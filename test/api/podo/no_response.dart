import 'package:networking/networking.dart';

class NoResponse implements SerializableObject<NoResponse> {
  @override
  NoResponse fromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}
