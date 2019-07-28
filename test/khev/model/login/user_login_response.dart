import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

class MockUserLoginResponse extends Mock implements UserLoginResponse {}

class UserLoginResponse implements SerializableObject<UserLoginResponse> {
  int authenticationType;
  String phoneNumber;

  UserLoginResponse({this.authenticationType, this.phoneNumber});

  UserLoginResponse.fromJson(Map<String, dynamic> json) {
    authenticationType = json['authenticationType'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticationType'] = this.authenticationType;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }

  @override
  UserLoginResponse fromJson(Map<String, dynamic> json) {
    return UserLoginResponse.fromJson(json);
  }
}
