import 'serializable.dart';

abstract class SerializableList<T> extends Serializable<T> {
  List<T> list = [];

  SerializableList();

  List<Map<String, dynamic>> toJsonList();

  List<T> fromJsonList(List<dynamic> json);
}
