import 'package:networking/networking.dart';

class ValidationErrors implements SerializableObject<ValidationErrors> {
  String message;

  ValidationErrors({this.message});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }

  @override
  ValidationErrors fromJson(Map<String, dynamic> json) {
    return ValidationErrors.fromJson(json);
  }
}
