import 'package:networking/networking.dart';
// import 'package:sample/api/error.dart';

class ErrorResponse implements SerializableObject<ErrorResponse> {
  bool isSuccessful;
  Error error;

  ErrorResponse({required this.isSuccessful, required this.error});

  // ErrorResponse.fromJson(Map<String, dynamic> json) {
  //   isSuccessful = json['isSuccessful'];
  //   error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccessful'] = this.isSuccessful;
    // data['error'] = this.error.toJson();

    return data;
  }

  @override
  ErrorResponse fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        error: Error(), //Error.fromJson(json['error']),
        isSuccessful: json["isSuccessful"]);
  }
}
