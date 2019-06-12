import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking/network_manager.dart';
import 'package:networking/networking/networking_factory.dart';

import 'api/podo/register_request.dart';

void main() {
  NetworkManager _manager;

  setUp(() {
    _manager = NetworkingFactory.create();
  });

  test('post method', () {
    RegisterRequest request = new RegisterRequest("hello", "world");

    _manager = NetworkingFactory.create();
    _manager
        .post(
          url: "https://reqres.in/api/register",
          body: request,
          listener: null,
        )
        .fetch();
  });
}
