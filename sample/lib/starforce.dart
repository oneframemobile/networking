// import 'package:flutter/material.dart';
// import 'package:networking/networking.dart';
// import 'package:sample/api/bean/request/change_password_request.dart';
// import 'package:sample/api/bean/request/forgot_password_request.dart';
// import 'package:sample/api/bean/request/login_request.dart';

// import 'api/bean/request/register_request.dart';
// import 'api/error_response.dart';
// import 'api/manager.dart';

// class StarforceView extends StatefulWidget {
//   @override
//   _StarforceViewState createState() => _StarforceViewState();
// }

// class _StarforceViewState extends State<StarforceView> {
//   ApiManager _apiManager = ApiManager.getInstance;

//   // LoginRequest loginRequest = new LoginRequest(email: "emre@emre.com", password: "emre1234emre");
//   LoginRequest loginRequest = new LoginRequest(email: "adminuser@kocsistem.com.tr", password: "123456");
//   RegisterRequest registerRequest = new RegisterRequest(email: "deneme1@deneme.com", password: "deneme1234", name: "deneme", surname: "denemesurname", phoneNumber: "05071914161");
//   ChangePasswordRequest changePasswordRequest = new ChangePasswordRequest(currentPassword: "emre1234emre", newPassword: "emre12345emre", newPasswordConfirmation: "emre12345emre");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appbar,
//       body: Center(
//         child: IntrinsicWidth(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[_registerRequest, _loginRequest, _getUserInfoRequest, _changePasswordRequest, _deleteUserRequest, _getRoleAssignmentsRequest],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget get _appbar => AppBar(
//         title: Text("StarForce Networking Sample"),
//       );

//   Widget get _registerRequest => RaisedButton.icon(
//         icon: Icon(Icons.app_registration),
//         onPressed: () async {
//           await _apiManager.register(
//               registerRequest: registerRequest,
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/register onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/register onerror");
//                 }));
//         },
//         label: Text("REGISTER Request"),
//       );

//   Widget get _loginRequest => RaisedButton.icon(
//         icon: Icon(Icons.login),
//         onPressed: () async {
//           await _apiManager.login(
//               loginRequest: loginRequest,
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/login onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/login onerror");
//                 }));
//         },
//         label: Text("LOGIN Request"),
//       );

//   Widget get _getUserInfoRequest => RaisedButton.icon(
//         icon: Icon(Icons.supervised_user_circle),
//         onPressed: () async {
//           await _apiManager.getUserInfo(
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/getUserInfo onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/getUserInfo onerror");
//                 }));
//         },
//         label: Text("GET USER INFO Request"),
//       );

//   Widget get _changePasswordRequest => RaisedButton.icon(
//         icon: Icon(Icons.change_history),
//         onPressed: () async {
//           await _apiManager.changePassword(
//               changePasswordRequest: changePasswordRequest,
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/changePassword onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/changePassword onerror");
//                 }));
//         },
//         label: Text("CHANGE PASSWORD Request"),
//       );

//   Widget get _deleteUserRequest => RaisedButton.icon(
//         icon: Icon(Icons.delete),
//         onPressed: () async {
//           await _apiManager.deleteUser(
//               userMail: "deneme1@deneme.com",
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/deleteUser onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/deleteUser onerror");
//                 }));
//         },
//         label: Text("DELETE USER Request"),
//       );

//   Widget get _getRoleAssignmentsRequest => RaisedButton.icon(
//         icon: Icon(Icons.rotate_left),
//         onPressed: () async {
//           await _apiManager.getRoleAssignments(
//               userMail: "adminuser@kocsistem.com.tr",
//               listener: new NetworkListener()
//                 ..onSuccess((dynamic result) {
//                   print("accounts/getRoleAssignments onsuccess");
//                 })
//                 ..onError((dynamic error) {
//                   print("accounts/getRoleAssignments onerror");
//                 }));
//         },
//         label: Text("RoleAssignments Request"),
//       );
// }
