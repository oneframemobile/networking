import 'package:networking/networking/serializable_object.dart';

class CampaignRequestModel implements SerializableObject<CampaignRequestModel> {
  int? categoryId;
  CampaignRequestModel();
  CampaignRequestModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    return data;
  }

  @override
  CampaignRequestModel fromJson(Map<String, dynamic> json) {
    return CampaignRequestModel.fromJson(json);
  }
}
