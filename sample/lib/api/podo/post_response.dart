import 'package:networking/networking.dart';
import 'package:sample/api/podo/base_response.dart';

class PostResponse extends BaseResponse implements SerializableList<Post>, SerializableObject<Post> {
  @override
  List<Post> list;

  @override
  List<Map<String, dynamic>> toJsonList() {
    throw new UnsupportedError("Not needed");
  }

  @override
  List<Post> fromJsonList(List json) {
    return json.map((fields) => Post.fromJsonMap(fields)).toList();
  }

  @override
  Post fromJson(Map<String, dynamic> json) {
    return Post.fromJsonMap(json);
  }

  @override
  Map<String, dynamic> toJson() {
    throw new UnsupportedError("");
  }
}

class Post implements SerializableObject<Post> {
  int userId;
  int id;
  String title;
  String body;

  Post.fromJsonMap(Map<String, dynamic> map)
      : userId = map["userId"],
        id = map["id"],
        title = map["title"],
        body = map["body"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  Post fromJson(Map<String, dynamic> map) {
    return Post.fromJsonMap(map);
  }
}
