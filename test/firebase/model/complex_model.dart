// import 'package:networking/networking/serializable_object.dart';

// class Complex extends SerializableObject<Complex> {
//   int code;
//   String status;
//   List<Users> users;

//   Complex({this.code, this.status, this.users});

//   Complex.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     if (json['users'] != null) {
//       users = new List<Users>();
//       json['users'].forEach((v) {
//         users.add(new Users.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     if (this.users != null) {
//       data['users'] = this.users.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

//   @override
//   Complex fromJson(Map<String, dynamic> json) => Complex.fromJson(json);
// }

// class Users extends SerializableObject {
//   String identity;
//   String name;
//   String surname;
//   String userID;

//   Users({this.identity, this.name, this.surname, this.userID});

//   Users.fromJson(Map<String, dynamic> json) {
//     identity = json['identity'];
//     name = json['name'];
//     surname = json['surname'];
//     userID = json['userID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['identity'] = this.identity;
//     data['name'] = this.name;
//     data['surname'] = this.surname;
//     data['userID'] = this.userID;
//     return data;
//   }

//   @override
//   fromJson(Map<String, dynamic> json) => Users.fromJson(json);
// }
