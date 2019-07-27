import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/networking.dart';
import 'api/podo/no_response.dart';
import 'api/podo/register_request.dart';
import 'api/podo/register_response.dart';
import 'api/podo/reqresin_error.dart';

void main() {
  NetworkingFactory.init();
  NetworkManager _manager;
  NetworkConfig _config = NetworkConfig();
  _config.setBaseUrl("https://hwasampleapi.firebaseio.com/");
  _manager = NetworkingFactory.create(config: _config);
  test('delete method test', () async {
    final isRemove = (await _manager
        .delete(url: "sample.json", type: NoPayload())
        .fetch()) as ResultModel<NoPayload>;

    expect(isRemove.data, isInstanceOf<NoPayload>());
  });
}
