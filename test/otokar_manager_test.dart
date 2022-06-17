import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'api/bean/error_response.dart';
import 'api/bean/request/login_request.dart';
import 'api/bean/response/login_response.dart';
import 'api/bean/response/otokar_notification_response.dart';
import 'local/local_host_learning.dart';

void main() {
  NetworkingFactory.init();
  NetworkConfig _config = NetworkConfig();
  NetworkManager _manager = NetworkingFactory.create(config: _config);
  LocalhostLearning _learning = new LocalhostLearning();
  _config.setBaseUrl("https://app.otokar.com.tr/api");
  _config.addSuccessCodes(200, 205);
  _config.setParseKey("resultData");
  _config.headers.add(Header(
      key: "Authorization",
      value:
          "Bearer dtnSUQ1kbg_A0cN7b3MFU-CTwittetlU8Ex0mtkrIEHE8DzS2nNm8Db8yUkE38JfogAwuebDj-ipmZelpMAPXWS4PalG2LOgsFU8WhRzHuaGgdhGvMoYg-NEBS4GQRLn-1cyqgaU_lO7TCExSKCRDqG4k9bcYbedWKkY2FP1ULhsWcFYhcafGK1Ctt_ykle30cwAQqsYxsX9k72IQTgCVgMop7nKD0jKLXqv3oJc0APdCVds8TmFl6aWMrDcXuMM1aqbqfaifoCIV1-Y4MVAHJF851ENEVMQH20yfLFQNswZiOk4rUAMsKPmPt8Wp4ASZ9pnCBP14xWFoQzvdQEvU7igdV4PyQQpEboD2HwNqg68PKUTKV5c76r3gx1QnorCbFVkhmyQOKspUd38Ajhu0aP90jvc-U3fUBDAxFCko31Vmq8-eqL5v1_vVk4HM49I",
      preserveHeaderCase: true));
  _config.headers
      .add(Header(key: "LanguageId", value: "1", preserveHeaderCase: true));
  _manager.learning = _learning;

  test('Wrong Password Login method test', () async {
    await _manager
        .get<OtokarNotificationResponseModel, ErrorResponse>(
            url: "/Notification/GetNotificationList",
            type: OtokarNotificationResponseModel(),
            errorType: ErrorResponse(),
            isList: true,
            listener: new NetworkListener()
              ..onSuccess((dynamic result) {
                expect(result, isInstanceOf<OtokarNotificationResponseModel>());
              })
              ..onError((dynamic error) {
                expect(error, isInstanceOf<ErrorModel>());
              }))
        .fetch();
  });
}
