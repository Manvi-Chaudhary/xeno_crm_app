import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xeno_crrm_app/models/AudienceModel.dart';
import 'package:xeno_crrm_app/models/CampaignModel.dart';

class APIModel {
  static APIModel shared = APIModel();

  Future<AudienceModel?> getAudience(int amountThreshold,int orderCountThreshold,String lastVisitedThreshold) async{
    print("${amountThreshold} ${orderCountThreshold} ${lastVisitedThreshold}");
    try{

      dynamic res= await http.get(Uri.parse("https://crmapi.onrender.com/order?amountThreshold=${amountThreshold}&orderCountThreshold=${orderCountThreshold}&lastVisitedThreshold=${lastVisitedThreshold}"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        int size = data.length;
        String audienceInfo = data.toString();
        return AudienceModel(size: size, audienceInfo: audienceInfo);
      }
      else{
        return null;
      }

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future addCampaign(String audienceInfo) async {
    final url = Uri.parse('https://crmapi.onrender.com/campaign');
    final Map<String, dynamic> requestBody = {
      'audience' : audienceInfo
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    if(response.statusCode==201){
      print(response.body);
    }
  }

  Future<List<CampaignModel>?> getAllCampaigns() async {
    try{

      dynamic res= await http.get(Uri.parse("https://crmapi.onrender.com/campaign"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var r = (data as List)
            .map((data) => new CampaignModel.fromJson(data))
            .toList();
        print(r);
        return r;
      }
      else{
        return null;
      }

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<String?> sendMessage(String communicationLogId) async{
    final url = Uri.parse('https://crmapi.onrender.com/campaign/send-message');
    final Map<String, dynamic> requestBody = {
      'communicationLogId' : communicationLogId
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );
    if(response.statusCode==201){
      print(response.body);
      var data = jsonDecode(response.body);
      return data["message"];
    }
    else {
      return null;
    }
  }
}