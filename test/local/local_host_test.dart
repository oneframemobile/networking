import 'package:flutter_test/flutter_test.dart';
import 'package:networking/networking.dart';

import 'local_host_learning.dart';
import 'model/book.dart';

void main() {
  NetworkManager manager;
  setUp(() {
    NetworkConfig _config = NetworkConfig();
    _config.setBaseUrl("http://localhost:4000/");
    manager = NetworkingFactory.create(
        config: _config, learning: LocalhostLearning());
  });
  test('get book list', () async {
    final response = await manager
        .get(url: "api/booksxsxs", type: Book())
        .fetch() as ResultModel;

    expect(response.data == null, false);
  });
}
