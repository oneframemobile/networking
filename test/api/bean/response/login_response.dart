import 'package:networking/networking/serializable_object.dart';

import '../../podo/base_response.dart';
import 'claim_list_response.dart';
import 'claim_response.dart';

class LoginResponse implements SerializableObject<LoginResponse> {
  List<ClaimResponse>? claims;
  String? token;
  String? refreshToken;
  LoginResponse() {}
  LoginResponse.fromJsonMap(Map<String, dynamic> json)
      : token = json["token"],
        refreshToken = json["refreshToken"];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['claims'] = claims;
    return data;
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJsonMap(json);
  }
}
