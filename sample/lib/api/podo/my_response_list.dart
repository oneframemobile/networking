import 'package:networking/networking.dart';
import 'package:sample/api/podo/my_response.dart';

class MyResponseList implements SerializableList<MyResponse> {
  @override
  List<MyResponse> list;

  @override
  List<MyResponse> fromJsonList(List json) {
    return json.map((fields) => MyResponse.fromJsonMap(fields)).toList();
  }

  @override
  List<Map<String, dynamic>> toJsonList() {
    throw new UnsupportedError("Not needed");
  }
}
