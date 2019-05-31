import 'package:networking/serializable.dart';

class ReqResInError implements Serializable<ReqResInError> {
  final String error;

  ReqResInError.fromJsonMap(Map<String, dynamic> map) : error = map["error"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = error;
    return data;
  }

  @override
  ReqResInError fromJson(Map<String, dynamic> json) {
    return ReqResInError.fromJsonMap(json);
  }
}
