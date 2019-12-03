import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

class MockUserErrorResponse extends Mock implements ErrorResponse {}

class ErrorResponse implements SerializableObject<ErrorResponse> {
  String activityId;
  String message;
  List<Items> items;

  ErrorResponse({this.activityId, this.message, this.items});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    message = json['message'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityId'] = this.activityId;
    data['message'] = this.message;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ErrorResponse fromJson(Map<String, dynamic> json) {
    return ErrorResponse.fromJson(json);
  }
}

class Items implements SerializableObject<Items> {
  @override
  Items fromJson(Map<String, dynamic> json) {
    return Items.fromJson(json);
  }

  int errorCode;
  String message;

  Items({this.errorCode, this.message});

  Items.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['message'] = this.message;
    return data;
  }
}
