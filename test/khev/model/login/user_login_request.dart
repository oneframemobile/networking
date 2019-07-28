import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

class MockUserLoginRequest extends Mock implements UserLoginRequest {}


class UserLoginRequest implements SerializableObject<UserLoginRequest> {
  String tckn;
  String password;

  UserLoginRequest({this.tckn, this.password});

  @override
  UserLoginRequest.fromJson(Map<String, dynamic> json) {
    tckn = json['tckn'];
    password = json['password'];
    return;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tckn'] = this.tckn;
    data['password'] = this.password;
    return data;
  }

  @override
  UserLoginRequest fromJson(Map<String, dynamic> json) {
    return UserLoginRequest.fromJson(json);
  }
}
