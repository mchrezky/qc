import 'package:flutter/material.dart';
import 'package:qc/constants.dart';
import 'package:qc/login.dart';
import 'package:qc/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String url_root = 'http://192.168.137.1/shti/index.php/api';
String url_root = 'http://192.168.100.10/qc-apps/frontend/web/';
String url_asset = 'http://192.168.100.10/qc-apps/frontend/web/';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MyApp> {
  int id_user;
  int status;

  @override
  void initState() {
    super.initState();
    _getId();
  }

  String result = "Hey there !";
  Future<int> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      id_user = (prefs.getInt('id') ?? false);
    });
  }

  Future<int> _getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = (prefs.getInt('status_login') ?? false);
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (id_user != null) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
    }else{
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
    }
  }
}
