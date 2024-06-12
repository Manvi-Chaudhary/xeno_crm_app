
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xeno_crrm_app/HomeScreen/Campaign.dart';
import 'package:xeno_crrm_app/HomeScreen/Homescreen.dart';


class Btmnav extends StatefulWidget {
  const Btmnav({Key? key}) : super(key: key);
  _BtmnavState createState() => _BtmnavState();
}

class _BtmnavState extends State<Btmnav> {
  @override
  int _selectedindex = 0;
  List<Widget> _page = [HomeScreen(), CampaignScreen()];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: "Campaign"),

        ],
        selectedItemColor: Colors.blue,

        currentIndex: _selectedindex,
        onTap: (int index) {
          setState(() {
            _selectedindex = index;
          });
        },
      ),
    );
  }
}