import 'package:networking/networking.dart';

import 'validation_errors.dart';

class Error implements SerializableObject<Error> {
  String correlationId;
  int code;
  String message;
  String details;
  List<ValidationErrors> validationErrors;

  Error({this.correlationId, this.code, this.message, this.details, this.validationErrors});

  Error.fromJson(Map<String, dynamic> json) {
    correlationId = json['correlationId'];
    code = json['code'];
    message = json['message'];
    details = json['details'];
    if (json['validationErrors'] != null) {
      validationErrors = new List<ValidationErrors>();
      json['validationErrors'].forEach((v) {
        validationErrors.add(new ValidationErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['correlationId'] = this.correlationId;
    data['code'] = this.code;
    data['message'] = this.message;
    data['details'] = this.details;
    if (this.validationErrors != null) {
      data['validationErrors'] = this.validationErrors.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Error fromJson(Map<String, dynamic> json) {
    return Error.fromJson(json);
  }
}
