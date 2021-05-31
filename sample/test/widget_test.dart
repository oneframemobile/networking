// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sample/api/bean/request/register_request.dart';
// import 'package:sample/api/bean/response/register_response.dart';
// import 'package:sample/api/manager.dart';

// import '../lib/main.dart';

// void main() {

//   testWidgets('Success Register Test', (WidgetTester tester) async {
//     ApiManager _apiManager = ApiManager.getInstance;

//     RegisterRequest registerRequest = new RegisterRequest(email: "deneme@deneme.com", password: "deneme1234", name: "deneme", surname: "denemesurname");
//     var response = await _apiManager.register(registerRequest: registerRequest);

//     expect(response.data, RegisterResponse());
//   });
// }
