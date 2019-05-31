abstract class Serializable<T> {
  Serializable();

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
