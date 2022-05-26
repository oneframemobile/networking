import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'api/bean/error_response.dart';
import 'api/bean/request/login_request.dart';
import 'api/bean/response/login_response.dart';
import 'local/local_host_learning.dart';

void main() {
  NetworkingFactory.init();
  NetworkConfig _config = NetworkConfig();
  NetworkManager _manager = NetworkingFactory.create(config: _config);
  LocalhostLearning _learning = new LocalhostLearning();
  _config.setBaseUrl("https://oneframe-livedemo-api.azurewebsites.net");
  _config.addSuccessCodes(200, 205);
  _config.setParseKey("result");
  _manager.learning = _learning;

  LoginRequest loginRequest =
      new LoginRequest(email: "adminuser@kocsistem.com.tr", password: "123456");
  LoginRequest wrongPasswordLoginRequest = new LoginRequest(
      email: "adminuser@kocsistem.com.tr", password: "123456777");

  test('Wrong Password Login method test', () async {
    await _manager
        .post<LoginRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/login",
            type: LoginResponse(),
            errorType: ErrorResponse(),
            body: loginRequest,
            listener: new NetworkListener()
              ..onSuccess((ResultModel result) {
                expect(result.data, isInstanceOf<LoginResponse>());
              })
              ..onError((ErrorModel error) {
                expect(error.data, isInstanceOf<Error>());
              }))
        .fetch();
  });
}
