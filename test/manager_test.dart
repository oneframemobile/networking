import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'api/bean/error.dart';
import 'api/bean/error_response.dart';
import 'api/bean/request/login_request.dart';
import 'api/bean/request/register_request.dart';
import 'api/bean/response/login_response.dart';
import 'api/bean/response/user_info_response.dart';
import 'local/local_host_learning.dart';

void main() {
  NetworkingFactory.init();
  NetworkManager _manager;
  NetworkConfig _config = NetworkConfig();
  LocalhostLearning _learning = new LocalhostLearning();
  _config.setBaseUrl("https://oneframe-livedemo-api.azurewebsites.net");
  _config.addSuccessCodes(200, 205);
  if (_manager == null) _manager = NetworkingFactory.create(config: _config);
  _manager.learning = _learning;

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMGNiMzNmMy01OTFhLTRhMjUtYWFiYS1iZDA1Zjc5NmI1ZmIiLCJ1bmlxdWVfbmFtZSI6ImFkbWludXNlckBrb2NzaXN0ZW0uY29tLnRyIiwianRpIjoiY2FhY2M5MDEtMDI5ZC00YzU3LWExOTMtZmI4ZDc5NTEzYjNhIiwiZW1haWwiOiJhZG1pbnVzZXJAa29jc2lzdGVtLmNvbS50ciIsImdpdmVuX25hbWUiOiJTY290IiwiZmFtaWx5X25hbWUiOiJMYXdzb24iLCJleHAiOjE2MDA5Mzk5NDUsImlzcyI6Ikp3dFNlcnZlciIsImF1ZCI6Ikp3dFNlcnZlciJ9.kOntnbCwiOD0gFp9CTSG8dSbpuYdAzRfVQfHepH2eC4";

  RegisterRequest registerRequest =
      new RegisterRequest(email: "deneme15@deneeme.com", password: "deneme1234", name: "deneme15", surname: "denemesurname15", phoneNumber: "05142914251");
  RegisterRequest wrongPhoneCodeRegisterRequest =
      new RegisterRequest(email: "deneme100@deneeme.com", password: "deneme1234", name: "deneme100", surname: "denemesurname100", phoneNumber: "050921914161");
  LoginRequest loginRequest = new LoginRequest(email: "adminuser@kocsistem.com.tr", password: "123456");
  LoginRequest wrongPasswordLoginRequest = new LoginRequest(email: "adminuser@kocsistem.com.tr", password: "123456777");


  test('Success register method test', () async {
    await _manager
        .post<RegisterRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/register",
            type: LoginResponse(),
            body: registerRequest,
            errorType: ErrorResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                expect(result.data, isInstanceOf<LoginResponse>());
              })
              ..onError((dynamic error) {
              }))
        .fetch();
  });

  test('Wrong Phone Code Format register method test', () async {
    await _manager
        .post<RegisterRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/register",
            type: LoginResponse(),
            body: wrongPhoneCodeRegisterRequest,
            errorType: ErrorResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
              })
              ..onError((dynamic error) {
                expect(error.data, isInstanceOf<Error>());
              }))
        .fetch();
  });

  test('Exist User register method test', () async {
    await _manager
        .post<RegisterRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/register",
            type: LoginResponse(),
            body: registerRequest,
            errorType: ErrorResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                expect(result.data, isInstanceOf<LoginResponse>());
              })
              ..onError((dynamic error) {
                expect(error.data, isInstanceOf<Error>());
              }))
        .fetch();
  });

  test('Success Login method test', () async {
    await _manager
        .post<LoginRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/login",
            type: LoginResponse(),
            errorType: ErrorResponse(),
            body: loginRequest,
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                token = result.data.token;
                expect(result.data, isInstanceOf<LoginResponse>());
              })
              ..onError((dynamic error) {
                //expect(error.data, isInstanceOf<Error>());
              }))
        .fetch();
  });

  test('Wrong Password Login method test', () async {
    await _manager
        .post<LoginRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/login",
            type: LoginResponse(),
            errorType: ErrorResponse(),
            body: wrongPasswordLoginRequest,
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                //expect(result.data, isInstanceOf<LoginResponse>());
              })
              ..onError((dynamic error) {
                expect(error.data, isInstanceOf<Error>());
              }))
        .fetch();
  });

  test('Success GetUserInfo method test', () async {
    await _manager
        .get<UserInfoResponse, ErrorResponse>(
            url: "/user/getUserInfo",
            type: UserInfoResponse(),
            errorType: ErrorResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                expect(result.data, isInstanceOf<UserInfoResponse>());
              })
              ..onError((dynamic error) {
              }))
        .addHeader(Header("Authorization", "Bearer $token"))
        .fetch();
  });

  test('Wrong Header GetUserInfo method test', () async {
    await _manager
        .get<UserInfoResponse, ErrorResponse>(
            url: "/user/getUserInfo",
            type: UserInfoResponse(),
            errorType: ErrorResponse(),
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
              })
              ..onError((dynamic error) {
                expect(error, isInstanceOf<ErrorModel>());
              }))
        .addHeader(Header("Authorization", "Bearer asdasd"))
        .fetch();
  });
}
