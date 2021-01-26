import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc/screens/home/home_screen.dart';
import 'package:qc/screens/home/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

// class MyBottomNavBar extends StatelessWidget {
  
class MyBottomNavBar extends StatefulWidget {
   const MyBottomNavBar({Key key, this.title, this.tab}) : super(key: key);

  final String title;
  final int tab;

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState(tab: tab);
}


class _MyBottomNavBarState extends State<MyBottomNavBar> {
  _MyBottomNavBarState({
    Key key,
    this.tab,
  });
  final int tab;
  @override
  void initState() {
    super.initState();
  } 

   Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //  runApp(MyApp());
    // Navigator.push(
    //         context,
    //         new MaterialPageRoute(
    //             builder: (BuildContext context) => new MyApp()));
    // Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (BuildContext context) => MyApp()),
    //         (Route<dynamic> route) => false);
    exit(0);
  }
  
  int currentTab = 0;
  String wallet =
      'assets/icons/wallet.svg'; // to keep track of active tab index
  final List<Widget> screens = [
    HomeScreen(),
    SettingsPage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();
  _changeIndex(int index) {
    print(index);
    setState(() {
      currentTab = index;
    });
    print("index");
    print(currentTab);
    if (currentTab == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ));
    }else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    }
  } 
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        currentIndex: tab,
        onTap: _changeIndex,
        items: [
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.home)),
         
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.person))
        ],
      );
  }
}
