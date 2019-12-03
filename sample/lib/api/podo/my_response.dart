import 'package:networking/networking.dart';

class MyResponse implements SerializableObject<MyResponse> {
  String username;

  MyResponse.fromJsonMap(Map<String, dynamic> map) : username = map["username"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    return data;
  }

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    return MyResponse.fromJsonMap(json);
  }
}
