import 'package:networking/networking.dart';

class MyResponse implements SerializableObject<MyResponse> {
  String selam;

  MyResponse.fromJsonMap(Map<String, dynamic> map) : selam = map["selam"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selam'] = selam;
    return data;
  }

  @override
  MyResponse fromJson(Map<String, dynamic> json) {
    return MyResponse.fromJsonMap(json);
  }
}
