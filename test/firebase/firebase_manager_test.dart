import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';

import 'model/complex_model.dart';
import 'model/mock_user.dart';

void main() {
  NetworkManager manager;

  setUp(() {
    NetworkingFactory.init();
    NetworkConfig _config = NetworkConfig();
    _config.setBaseUrl("https://swaggercodegen.firebaseio.com/");
    manager = NetworkingFactory.create(config: _config);
  });

  test('firebase user list', () async {
    var response = (await manager
        .get(url: "users.json", asList: true, type: UserList())
        .fetch()) as ResultModel<UserList>;

    print(response.data.list);

    expect(response.data.list.length > 0, true);
  });

  test('firebase add post user', () async {
    var user =
        User(identity: "asd", name: "vv", surname: "asdasd", userID: "1234");

    var response = (await manager
        .post(url: "user.json", body: user, type: NoPayload())
        .fetch()) as ResultModel<dynamic>;

    expect(response.data, null);
  });

  test('firebase add put user', () async {
    var user =
        User(identity: "asd", name: "vv", surname: "asdasd", userID: "1234");

    var responseUserList = (await manager
        .get(url: "users.json", asList: true, type: UserList())
        .fetch()) as ResultModel<UserList>;
    final lastIndex = responseUserList.data.list.length;

    var response = (await manager
        .put(url: "users/$lastIndex.json", body: user, type: NoPayload())
        .fetch()) as ResultModel<NoPayload>;

    expect(response.data != null, true);
  });

  test('firebase delete  user', () async {
    var responseUserList = (await manager
        .get(url: "users.json", asList: true, type: UserList())
        .fetch()) as ResultModel<UserList>;
    final lastIndex = responseUserList.data.list.length - 1;

    var response = (await manager
        .delete(url: "users/$lastIndex.json", type: NoPayload())
        .fetch()) as ResultModel<NoPayload>;

    expect(response.data != null, true);
  });

  test('firebase get modal', () async {
    var response = (await manager.get(url: ".json", type: Complex()).fetch())
        as ResultModel<Complex>;

    print(response.data);

    expect(response.data.code, 1);
  });

  test('firebase path modal', () async {
    var response = (await manager.get(url: ".json", type: Complex()).fetch())
        as ResultModel;

    int statusParse =
        resolve(json: response.json, path: "code", defaultValue: 10);
    List<Users> usesrList = resolve(
            json: response.json, path: "users", defaultValue: List<dynamic>())
        .cast<Users>()
        .toList();

    expect(usesrList.isNotEmpty, true);
  });
}

T resolve<T>({Map<String, dynamic> json, String path, T defaultValue}) {
  try {
    dynamic current = json;
    path.split('.').forEach((segment) {
      final maybeInt = int.tryParse(segment);

      if (maybeInt != null && current is List<dynamic>) {
        current = current[maybeInt];
      } else if (current is Map<String, dynamic>) {
        current = current[segment];
      }
    });

    return (current as T) ?? defaultValue;
  } catch (error) {
    print(error);
    return defaultValue;
  }
}
