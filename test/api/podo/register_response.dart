import 'package:networking/networking.dart';

import 'base_response.dart';

class RegisterResponse with BaseResponse implements SerializableObject<RegisterResponse> {
  int id;
  String token;

  RegisterResponse();

  RegisterResponse.fromJsonMap(Map<String, dynamic> json)
      : id = json["id"],
        token = json["token"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['token'] = token;
    return data;
  }

  @override
  RegisterResponse fromJson(Map<String, dynamic> json) {
    return RegisterResponse.fromJsonMap(json);
  }
}
