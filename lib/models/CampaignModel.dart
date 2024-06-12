class CampaignModel {
  int audienceSize ;

  String communicationLogId;
  String date;

  CampaignModel({required this.audienceSize,required this.date,required this.communicationLogId});

  factory CampaignModel.fromJson(Map<String, dynamic> parsedJson){
    var audience = parsedJson['audience'];
    var date = parsedJson['createdAt'];
    var communicationLogId = parsedJson["_id"];
    if(audience==null || date==null){

      return CampaignModel(audienceSize: 0, date: "",communicationLogId: "");
    }
    return CampaignModel(audienceSize: audience.length, date: date.toString(),communicationLogId: communicationLogId);
  }
}