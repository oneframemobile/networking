import 'package:networking/networking.dart';

import '../../podo/base_response.dart';

class DefaultResponse with BaseResponse implements SerializableObject<DefaultResponse> {
  bool isSuccessful;
  String error;

  DefaultResponse();

  DefaultResponse.fromJsonMap(Map<String, dynamic> json)
      : isSuccessful = json["isSuccessful"],
        error = json["error"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccessful'] = isSuccessful;
    data['error'] = error;
    return data;
  }

  @override
  DefaultResponse fromJson(Map<String, dynamic> json) {
    return DefaultResponse.fromJsonMap(json);
  }
}
