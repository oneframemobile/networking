import 'package:networking/networking/serializable.dart';

class RegisterRequest implements Serializable<RegisterRequest> {
  final String email;
  final String password;

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
  RegisterRequest fromJson(Map<String, dynamic> json) {
    return RegisterRequest.fromJsonMap(json);
  }
}
