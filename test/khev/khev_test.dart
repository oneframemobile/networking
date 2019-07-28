import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'model/error_response.dart';
import 'model/login/user_login_request.dart';
import 'model/login/user_login_response.dart';

const BASE_API_URL = "http://khevapi-test.kocsistem.com.tr/";
const String LOGIN_USER = "users/login";

void main() {
  NetworkingFactory.init();
  NetworkManager _manager;
  NetworkConfig _config = NetworkConfig();
  _config.setBaseUrl("$BASE_API_URL");
  _manager = NetworkingFactory.create(config: _config);
  test('login user error ', () async {
    final data = await _manager
        .post<UserLoginRequest, UserLoginResponse, ErrorResponse>(
          url: LOGIN_USER,
          type: UserLoginResponse(),
          errorType: ErrorResponse(),
          body: UserLoginRequest(tckn: "10606086186", password: "123456Aa"),
        )
        .fetch();

    expect(data.data, isInstanceOf<ErrorResponse>());
  });
}
