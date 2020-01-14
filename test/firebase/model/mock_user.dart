import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

class User extends SerializableObject<User> {
  String identity;
  String name;
  String surname;
  String userID;

  User({this.identity, this.name, this.surname, this.userID});

  User.fromJson(Map<String, dynamic> json) {
    identity = json['identity'];
    name = json['name'];
    surname = json['surname'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identity'] = this.identity;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['userID'] = this.userID;
    return data;
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}

class MockUser extends Mock implements User {}
