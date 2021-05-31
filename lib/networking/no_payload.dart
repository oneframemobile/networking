import 'serializable_object.dart';

class NoPayload extends SerializableObject<NoPayload> {
  NoPayload();
  @override
  NoPayload fromJson(Map<String, dynamic> json) {
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }
}
