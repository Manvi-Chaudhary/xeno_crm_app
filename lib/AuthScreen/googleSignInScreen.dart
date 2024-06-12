import 'package:flutter/material.dart';
import 'package:xeno_crrm_app/HomeScreen/Btmnav.dart';
import 'package:xeno_crrm_app/HomeScreen/Homescreen.dart';
import "package:xeno_crrm_app/models/Authentication.dart";
class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor:  Color.fromRGBO(225,225,225,1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CRM App",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 50),),
              SizedBox(height: 100,),
              Container(
                padding: EdgeInsets.all(20),
                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/google.png",height: 20,width: 20,),
                      Text("Sign In with Google",style: TextStyle(fontWeight: FontWeight.w500),)
                    ],
                  ),
                  onTap: () async {
                    dynamic res = await Authentication.sharedAuth.signInWithGoogle();
                    if(res==null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to Sign In",style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent,));
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Btmnav()));
                    }
                  },
                ),
              ),
              SizedBox(height: 200,),
              Text("Developed by Manvi Chaudhary",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
            ],
          ),
        ),
      ),
    );
  }
}
