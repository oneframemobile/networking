import 'package:networking/networking/serializable_object.dart';

class Book extends SerializableObject<Book> {
  bool read;
  String sId;
  String title;
  String genre;
  String author;

  Book({this.read, this.sId, this.title, this.genre, this.author});

  Book.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    sId = json['_id'];
    title = json['title'];
    genre = json['genre'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['genre'] = this.genre;
    data['author'] = this.author;
    return data;
  }

  @override
  Book fromJson(Map<String, dynamic> json) {
    return Book.fromJson(json);
  }
}
