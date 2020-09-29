import 'package:networking/networking/serializable_object.dart';

class LoginRequest implements SerializableObject<LoginRequest> {
  String email;
  String password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromJsonMap(Map<String, dynamic> map)
      : email = map["email"],
        password = map["password"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  LoginRequest fromJson(Map<String, dynamic> map) {
    return LoginRequest.fromJsonMap(map);
  }
}
