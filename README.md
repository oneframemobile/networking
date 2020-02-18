
# networking

[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/flutterchina/dio)

Http client for Dart also Flutter. Networking supports Serilazation, Global Configuration, Learning, Timeout etc.

## Get started

### Add dependency

```yaml
dependencies:
  networking: x #latest version
```

### Requirement

1. We define global configiration class.
2. If you have complex scenario, you can define Learning class.
3. And finally define model class but you dont't forget model class must be extends Serialable Object or List

### Basic Request

```dart
import 'package:networking/networking.dart';

await manager
        .get(url: "users.json", asList: true, type: UserList())
        .fetch()) as ResultModel<UserList>
}
```

### Network Config

```dart
import 'package:networking/networking.dart';
NetworkConfig getConfigure() {
    NetworkConfig _config = NetworkConfig();
    _config.setBaseUrl("https://hwasampleapi.firebaseio.com/");
    _config.addHeaderWithParameters("token", "EXAMPLE_TOKEN");
    return _config;
}
```

### Network Manager

```dart
import 'package:networking/networking.dart';
NetworkManager manager =  NetworkingFactory.create(config: getConfigure())
```

### Basic Model

```dart
class User extends SerializableObject<User> {
  String name;

  User({this.name});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}

```
