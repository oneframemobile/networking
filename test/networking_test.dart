import 'package:flutter_test/flutter_test.dart';
import 'package:networking/model/error_model.dart';
import 'package:networking/model/result_model.dart';
import 'package:networking/network_listener.dart';
import 'package:networking/network_manager.dart';
import 'package:networking/networking_factory.dart';
import 'package:networking/serializable.dart';

import 'api/podo/register_request.dart';
import 'api/podo/register_response.dart';

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
        .run();
  });
}
