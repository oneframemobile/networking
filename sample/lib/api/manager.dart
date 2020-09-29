import 'package:flutter/cupertino.dart';
import 'package:networking/networking.dart';
import 'package:networking/networking/network_manager.dart';
import 'package:networking/networking/networking_factory.dart';
import 'package:sample/api/bean/request/login_request.dart';
import 'package:sample/api/bean/request/register_request.dart';
import 'package:sample/api/error_response.dart';
import 'package:sample/api/one_frame_learning.dart';

import 'base_api_helper.dart';
import 'bean/request/change_password_request.dart';
import 'bean/response/default_response.dart';
import 'bean/response/login_response.dart';
import 'bean/response/role_assignment_response.dart';
import 'bean/response/user_info_response.dart';

class ApiManager {
  NetworkManager _manager;

  static ApiManager instance = new ApiManager._apiManager();

  ApiManager._apiManager() {
    NetworkConfig _config = NetworkConfig();
    OneFrameLearning _learning = new OneFrameLearning();
    _config.setBaseUrl("https://oneframe-livedemo-api.azurewebsites.net");
    _config.addSuccessCodes(200, 205);
    if (_manager == null) _manager = NetworkingFactory.create(config: _config);
    _manager.learning = _learning;
  }

  static ApiManager get getInstance => instance;

  Future register({RegisterRequest registerRequest, NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .post<RegisterRequest, LoginResponse, ErrorResponse>(
            url: "/accounts/register", type: LoginResponse(), body: registerRequest, errorType: ErrorResponse(), listener: listener)
        .fetch();
  }

  Future login({@required LoginRequest loginRequest, NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .post<LoginRequest, LoginResponse, ErrorResponse>(url: "/accounts/login", type: LoginResponse(), errorType: ErrorResponse(), body: loginRequest, listener: listener)
        .fetch();
  }

  Future getUserInfo({NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .get<UserInfoResponse, ErrorResponse>(url: "/user/getUserInfo", type: UserInfoResponse(), errorType: ErrorResponse(), listener: listener)
        .addHeader(BaseApiHelper.getInstance().tokenHeader)
        .fetch();
  }

  Future getRoleAssignments({String userMail, NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .get<RoleListResponse, ErrorResponse>(url: "/accounts/GetRoleAssignments/" + userMail, type: RoleListResponse(), errorType: ErrorResponse(), listener: listener)
        .addHeader(BaseApiHelper.getInstance().tokenHeader)
        .asList(true)
        .parseKey("result")
        .fetch();
  }

  Future changePassword({@required ChangePasswordRequest changePasswordRequest, NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .put<ChangePasswordRequest, DefaultResponse, ErrorResponse>(
            url: "/accounts/changePassword", errorType: ErrorResponse(), type: DefaultResponse(), body: changePasswordRequest, listener: listener)
        .addHeader(BaseApiHelper.getInstance().tokenHeader)
        .fetch();
  }

  Future deleteUser({String userMail, NetworkListener<dynamic, dynamic> listener}) async {
    await _manager
        .delete<DefaultResponse, ErrorResponse>(url: "/accounts/" + userMail, errorType: ErrorResponse(), type: DefaultResponse(), listener: listener)
        .addHeader(BaseApiHelper.getInstance().tokenHeader)
        .fetch();
  }
}
