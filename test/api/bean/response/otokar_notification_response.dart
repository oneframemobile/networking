import 'package:networking/networking/serializable_object.dart';

class OtokarNotificationResponseModel
    extends SerializableObject<OtokarNotificationResponseModel> {
  String? description;
  String? categoryName;
  String? url;
  String? extension;
  int? type;
  int? notificationTransId;
  String? startDate;
  String? finishDate;
  String? title;
  bool? isDeleted;
  String? creationTime;
  int? id;

  OtokarNotificationResponseModel(
      {this.description,
      this.categoryName,
      this.url,
      this.extension,
      this.type,
      this.notificationTransId,
      this.startDate,
      this.finishDate,
      this.title,
      this.isDeleted,
      this.creationTime,
      this.id});

  OtokarNotificationResponseModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    categoryName = json['categoryName'];
    url = json['url'];
    extension = json['extension'];
    type = json['type'];
    notificationTransId = json['notificationTransId'];
    startDate = json['startDate'];
    finishDate = json['finishDate'];
    title = json['title'];
    isDeleted = json['isDeleted'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['categoryName'] = this.categoryName;
    data['url'] = this.url;
    data['extension'] = this.extension;
    data['type'] = this.type;
    data['notificationTransId'] = this.notificationTransId;
    data['startDate'] = this.startDate;
    data['finishDate'] = this.finishDate;
    data['title'] = this.title;
    data['isDeleted'] = this.isDeleted;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }

  @override
  OtokarNotificationResponseModel fromJson(Map<String, dynamic> json) {
    return OtokarNotificationResponseModel.fromJson(json);
  }
}
