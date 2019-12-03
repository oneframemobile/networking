import 'package:networking/networking.dart';

class RegisterRequest implements SerializableObject<RegisterRequest> {
  String email;
  String password;

  RegisterRequest(this.email, this.password);

  RegisterRequest.fromJsonMap(Map<String, dynamic> map)
      : email = map["email"],
        password = map["password"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  RegisterRequest fromJson(Map<String, dynamic> map) {
    return RegisterRequest.fromJsonMap(map);
  }
}
