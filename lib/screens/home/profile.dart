import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() {
    return ProfileState();
  }
}

// Create a corresponding State class. This class will hold the data related to

// the form.

class ProfileState extends State<Profile> {
  TextEditingController nama = new TextEditingController();
  TextEditingController tgl_lahir = new TextEditingController();
  TextEditingController emails = new TextEditingController();
  TextEditingController jk = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._fetchData();
  }

  Map data;
  List userData;
  String username='';
  String email='';
  var isLoading = false;

  Future _fetchData() async {
    print("fetch");
    // print(todo);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     int id = (prefs.getInt('id') ?? false);
     print(id);
    var jsonResponse = null;
    final response =
        await http.get(url_root + "index.php?r=auth/view&id="+id.toString());
    print(response.statusCode);
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      // if (json.decode(response.body)['status'] != 0) {

      print("login ok");
      setState(() {
        username = jsonResponse["username"];
        email = jsonResponse["email"];
        // nosewa = jsonResponse["data"]["no_sewa"];
      });
      print("list");
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    nama.text = username;
    emails.text = email;
    // Build a Form widget using the _formKey we created above
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actionsIconTheme: Colors.black,
        title: Text(
          "Profil Saya",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    // Text('Join Flutter and have fun'),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // TextFormField(
                    //   decoration:
                    //       InputDecoration(hintText: "Nama", labelText: "Nama"),
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please enter some text';
                    //     }
                    //   },
                    // ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          labelText: "Username",
                          suffixIcon: Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        controller: nama,
                        enabled: false,
                      ),
                      // subtitle: Text("Adi Putra"),
                      // trailing: Icon(
                      //   Icons.edit,
                      //   color: Colors.grey,
                      // ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      title: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                          suffixIcon: Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        controller: emails,
                        enabled: false,
                      ),
                      // subtitle: Text("Adi Putra"),
                      // trailing: Icon(
                      //   Icons.edit,
                      //   color: Colors.grey,
                      // ),
                    ),
                    
                      // subtitle: Text("Adi Putra"),
                      // trailing: Icon(
                      //   Icons.edit,
                      //   color: Colors.grey,
                      // ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
     
    );
  }

}

