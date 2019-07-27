import 'serializable_object.dart';

class NoPayload extends SerializableObject<Null> {
  NoPayload();
  @override
  Null fromJson(Map<String, dynamic> json) {
    return null;
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}
