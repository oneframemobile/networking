import 'package:networking/networking.dart';

class ClaimResponse implements SerializableObject<ClaimResponse> {
  String name;

  ClaimResponse.fromJsonMap(Map<String, dynamic> map) : name = map["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    return data;
  }

  @override
  ClaimResponse fromJson(Map<String, dynamic> json) {
    return ClaimResponse.fromJsonMap(json);
  }
}
