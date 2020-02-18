import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';
import 'api/podo/no_response.dart';
import 'api/podo/register_request.dart';
import 'api/podo/register_response.dart';
import 'api/podo/reqresin_error.dart';

void main() {
  NetworkManager _manager;
  test('post method', () async {
    RegisterRequest request = new RegisterRequest(
      "eve.holt@reqres.in",
      "pistol",
    );

    _manager = NetworkingFactory.create();
    await _manager
        .post<RegisterRequest, RegisterResponse>(
            url: "https://reqres.in/api",
            body: request,
            type: new RegisterResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                print("success");
              })
              ..onError((dynamic error) {
                print("fail");
              }))
        .path("register")
        .query("userId", "10")
        .addHeader(new Header("My", "Header"))
        .fetch();
  });

  test('timeout method', () async {
    _manager = NetworkingFactory.create();
    await _manager
        .get<NoResponse>(
            url: "https://httpstat.us/200?sleep=5000",
            type: new NoResponse(),
            timeout: new Duration(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                print("success");
              })
              ..onError((dynamic error) {
                print("fail");
              }))
        .fetch();
  });
}
