import 'package:networking/networking.dart';
import 'package:sample/api/podo/base_response.dart';

class UserInfoResponse with BaseResponse implements SerializableObject<UserInfoResponse> {
  String email;
  bool emailConfirmed;
  String name;
  String phoneNumber;
  String surname;

  UserInfoResponse();

  UserInfoResponse.fromJsonMap(Map<String, dynamic> json)
      : email = json["email"],
        emailConfirmed = json["emailConfirmed"],
        name = json["name"],
        phoneNumber = json["phoneNumber"],
        surname = json["surname"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['emailConfirmed'] = emailConfirmed;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['surname'] = surname;
    return data;
  }
  @override
  UserInfoResponse fromJson(Map<String, dynamic> json) {
    return UserInfoResponse.fromJsonMap(json["result"]);
  }
}
