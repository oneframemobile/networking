import 'package:networking/networking/serializable_list.dart';

import 'claim_response.dart';

class ClaimListResponse implements SerializableList<ClaimResponse> {
  @override
  List<ClaimResponse>? list;

  @override
  List<ClaimResponse> fromJsonList(List json) {
    return json.map((fields) => ClaimResponse.fromJsonMap(fields)).toList();
  }

  @override
  List<Map<String, dynamic>> toJsonList() {
    throw new UnsupportedError("Not needed");
  }
}
