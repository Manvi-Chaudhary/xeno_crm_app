import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:xeno_crrm_app/models/APIModel.dart';
import 'package:xeno_crrm_app/models/AudienceModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  int amountThreshold = 0;
  int orderCountThreshold = 0;

  int lastVisitedThreshold = 0;

  AudienceModel? audience ;

  final _formkey = GlobalKey<FormState>();

  DateTime subtractMonths(DateTime date, int months) {
    int year = date.year;
    int month = date.month - months;

    while (month <= 0) {
      month += 12;
      year -= 1;
    }
    int day = date.day;
    int lastDayOfNewMonth = DateTime(year, month + 1, 0).day;

    if (day > lastDayOfNewMonth) {
      day = lastDayOfNewMonth;
    }

    return DateTime(year, month, day, date.hour, date.minute, date.second, date.millisecond, date.microsecond);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: Text("CRM Application",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formkey,
          child: Container(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Spends",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(239,239,239,1),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Total Spends",
                            hintStyle: TextStyle(color: Color.fromRGBO(198,198,198,1))
                        ),
                        onChanged: (value){
                          amountThreshold= int.parse(value);
                         
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Maximum Visit",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(239,239,239,1),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Maximum Visit",
                            hintStyle: TextStyle(color: Color.fromRGBO(198,198,198,1))
                        ),
                        onChanged: (value){
                          orderCountThreshold= int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Last Visit",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(239,239,239,1),
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Last Visit(in months)",
                            hintStyle: TextStyle(color: Color.fromRGBO(198,198,198,1))
                        ),
                        onChanged: (value){
                          setState(() {
                            lastVisitedThreshold= int.parse(value);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 50,),
                    TextButton(onPressed: () async {
                      DateTime now = DateTime.now();
                      DateTime newDate = subtractMonths(now, lastVisitedThreshold);
                      String isoDate = newDate.toIso8601String();
                      print(newDate.month);
                      AudienceModel? res = await APIModel.shared.getAudience(amountThreshold, orderCountThreshold, isoDate);
                      if(res!=null){
                        setState(() {
                          audience = res;
                        });
                      }
                    },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Check Audience Size",style: TextStyle(color: Colors.white),),
                        )
                    ),
                    SizedBox(height: 20,),
                    TextButton(onPressed: () async {
                      if(audience!=null){
                        await APIModel.shared.addCampaign(audience!.audienceInfo);
                      }

                    },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Save Audience",style: TextStyle(color: Colors.white),),
                        )
                    ),
                    SizedBox(height: 20,),
                    Text("Audience size is : ${(audience!=null) ? audience!.size : 0}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
