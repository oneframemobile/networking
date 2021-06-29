import 'package:networking/networking/serializable_object.dart';

class CampaignResponseModel
    implements SerializableObject<CampaignResponseModel> {
  String? responseCode;
  String? responseDescription;
  List<Campaigns>? campaigns;
  CampaignResponseModel();
  CampaignResponseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    responseDescription = json['ResponseDescription'];
    if (json['Campaigns'] != null) {
      campaigns = [];
      json['Campaigns'].forEach((v) {
        campaigns!.add(new Campaigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['ResponseDescription'] = this.responseDescription;
    if (this.campaigns != null) {
      data['Campaigns'] = this.campaigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  CampaignResponseModel fromJson(Map<String, dynamic> json) {
    return CampaignResponseModel.fromJson(json);
  }
}

class Campaigns {
  String? id;
  String? title;
  String? subDescription;
  String? description;
  String? bannerImageUrl;
  String? fullImageUrl;
  bool? isAnyCampaignCode;
  bool? isSentCampaignCode;
  bool? isQrCodeShowing;
  String? startDate;
  String? endDate;
  String? lastParticipationDate;
  String? remainingDayCounter;
  Campaigns();
  Campaigns.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    subDescription = json['SubDescription'];
    description = json['Description'];
    bannerImageUrl = json['BannerImageUrl'];
    fullImageUrl = json['FullImageUrl'];
    isAnyCampaignCode = json['IsAnyCampaignCode'];
    isSentCampaignCode = json['IsSentCampaignCode'];
    isQrCodeShowing = json['IsQrCodeShowing'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    lastParticipationDate = json['LastParticipationDate'];
    remainingDayCounter = json['RemainingDayCounter'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['SubDescription'] = this.subDescription;
    data['Description'] = this.description;
    data['BannerImageUrl'] = this.bannerImageUrl;
    data['FullImageUrl'] = this.fullImageUrl;
    data['IsAnyCampaignCode'] = this.isAnyCampaignCode;
    data['IsSentCampaignCode'] = this.isSentCampaignCode;
    data['IsQrCodeShowing'] = this.isQrCodeShowing;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['LastParticipationDate'] = this.lastParticipationDate;
    data['RemainingDayCounter'] = this.remainingDayCounter;
    return data;
  }
}
