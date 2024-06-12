import 'package:flutter/material.dart';
import 'package:xeno_crrm_app/models/APIModel.dart';
import 'package:xeno_crrm_app/models/CampaignModel.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {

  @override

  List<CampaignModel> campaigns = [];

  void getCampaignList() async{
    dynamic res = await APIModel.shared.getAllCampaigns();
    if(res!=null){
      setState(() {
        campaigns = res!;
      });
    }
  }
  void initState()  {
    // TODO: implement initState
    super.initState();
    getCampaignList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaigns",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(itemBuilder: (BuildContext context,int index){
        print(campaigns[index].audienceSize);

        String isoString = campaigns[index].date;
        DateTime dateTime = DateTime.parse(isoString);
        return Container(
          padding: EdgeInsets.all(10),
          margin: (index==0) ? EdgeInsets.only(left: 10,right: 10,top: 10) : EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Audience Size : ${campaigns[index].audienceSize}"),
                  Text("Created At : ${dateTime.day},${dateTime.month},${dateTime.year}")
                ],
              ),
              TextButton(onPressed: () async {
                var res = await APIModel.shared.sendMessage(campaigns[index].communicationLogId);
                if(res!=null){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res,style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Error occured.Message was not sent",style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent,));
                }
              },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("Send Message",style: TextStyle(color: Colors.white),),
                  )
              )
            ],
          ),
        );

      }, separatorBuilder: (BuildContext context,int index){
        return SizedBox(height: 10,);

      }, itemCount: campaigns.length),
    );
  }
}
