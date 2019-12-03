import 'serializable.dart';

abstract class SerializableObject<T> extends Serializable<T> {
  SerializableObject();

  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);
}
