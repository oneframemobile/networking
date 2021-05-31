// import 'package:networking/networking/serializable_list.dart';

// class Role {
//   String roleName;
//   bool isAssigned;

//   Role({this.roleName, this.isAssigned});

//   Role.fromJson(Map<String, dynamic> json) {
//     roleName = json['roleName'];
//     isAssigned = json['isAssigned'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['roleName'] = this.roleName;
//     data['isAssigned'] = this.isAssigned;
//     return data;
//   }
// }

// class RoleListResponse implements SerializableList<Role> {
//   @override
//   List<Role> list;

//   @override
//   List<Role> fromJsonList(List json) {
//     return json.map((fields) => Role.fromJson(fields)).toList();
//   }

//   @override
//   List<Map<String, dynamic>> toJsonList() {
//     throw new UnsupportedError("Not needed");
//   }
// }
