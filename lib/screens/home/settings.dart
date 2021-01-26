import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc/components/my_bottom_nav_bar.dart';
import 'package:qc/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // actionsIconTheme: Colors.black,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.white,
          Colors.white,
        ])),
        child: ListView(
          children: <Widget>[
            ListTile(
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage(horseUrl),
              // ),
              leading: Icon(Icons.person),
              title: Text('Profil Saya'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => new Profile()));
              },
              // selected: true,
            ),
            
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Keluar'),
              onTap: () async {
                // Future logout() async {
                  // timer.cancel();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                //  runApp(MyApp());
                // Navigator.push(
                //         context,
                //         new MaterialPageRoute(
                //             builder: (BuildContext context) => new MyApp()));
                Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) => MyApp()),
                        (Route<dynamic> route) => false);
                // exit(0);
                // }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        tab: 1,
      ),
     
    );
  }
}
