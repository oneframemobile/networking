// import 'package:networking/networking.dart';

// class RegisterRequest implements SerializableObject<RegisterRequest> {
//   String email;
//   String password;
//   String phoneNumber;
//   String name;
//   String surname;

//   RegisterRequest({this.email, this.password, this.phoneNumber, this.name, this.surname});

//   RegisterRequest.fromJsonMap(Map<String, dynamic> map)
//       : email = map["email"],
//         password = map["password"],
//         phoneNumber = map["phoneNumber"],
//         name = map["name"],
//         surname = map["surname"];

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = email;
//     data['password'] = password;
//     data['phoneNumber'] = phoneNumber;
//     data['name'] = name;
//     data['surname'] = surname;
//     return data;
//   }

//   @override
//   RegisterRequest fromJson(Map<String, dynamic> map) {
//     return RegisterRequest.fromJsonMap(map);
//   }
// }
