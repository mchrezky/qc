import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qc/components/my_bottom_nav_bar.dart';
import 'package:qc/constants.dart';
import 'package:qc/screens/home/listsewa.dart';
import 'package:qc/screens/home/qclist.dart';
import 'package:qc/screens/home/questionlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatelessWidget {
int id_user;
String username;
String level;
String upi;
String result = "Hey there !";

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getId();
    _getName();
    _getLevel();
    _getUpi();
  }

  String result = "Hey there !";
  Future<int> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      id_user = (prefs.getInt('id') ?? false);
    });
  }

  Future<String> _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? false);
    });
  }

  Future<String> _getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      level = (prefs.getString('role') ?? false);
    });
  }

  Future<String> _getUpi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      upi = (prefs.getString('id_upi') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
          // backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new HomeScreen()));
              }, // omitting onPressed makes the button disabled
            ),
          ),
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
              // It will cover 20% of our total height
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 36 + kDefaultPadding,
                    ),
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Hi, ' + username,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset("assets/images/logoefish.png")
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                     Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new QuestionList(),
                                                settings: RouteSettings(
                                                    arguments: value)));
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                // surffix isn't working properly  with SVG
                                // thats why we use row
                                // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                              ),
                            ),
                          ),
                          SvgPicture.asset("assets/icons/search.svg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 24,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding / 4),
                    child: Text(
                      "Wait For QC",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(right: kDefaultPadding / 4),
                      height: 7,
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                  )
                ],
              ),
            ),
            // RecomendsPlants(),
            QcList(),
            Container(
              height: 24,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: kDefaultPadding / 4),
                    child: Text(
                      "History QC",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(right: kDefaultPadding / 4),
                      height: 7,
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                  )
                ],
              ),
            ),
            ListSewa(),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        tab: 0,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/refresh.svg"),
        onPressed: () {},
      ),
    );
  }
}
