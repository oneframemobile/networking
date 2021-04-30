import 'package:networking/networking/serializable_object.dart';

class ChangePasswordRequest implements SerializableObject<ChangePasswordRequest> {
  String currentPassword;
  String newPassword;
  String newPasswordConfirmation;

  ChangePasswordRequest({this.currentPassword, this.newPassword, this.newPasswordConfirmation});

  ChangePasswordRequest.fromJsonMap(Map<String, dynamic> map)
      : currentPassword = map["currentPassword"],
        newPassword = map["newPassword"],
        newPasswordConfirmation = map["newPasswordConfirmation"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    data['newPasswordConfirmation'] = newPasswordConfirmation;
    return data;
  }

  @override
  ChangePasswordRequest fromJson(Map<String, dynamic> map) {
    return ChangePasswordRequest.fromJsonMap(map);
  }
}
