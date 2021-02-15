import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qc/main.dart';
import 'package:http/http.dart' as http;
import 'package:qc/screens/home/questionlist.dart';


class ResultPage extends StatefulWidget {
  ResultPage({Key key,this.id}) : super(key: key);

  final String id;
  @override
  _ResultState createState() => _ResultState(id: id);
}

class _ResultState extends State<ResultPage> {
  _ResultState({
    Key key,
    this.id,
  });
  final String id;
  @override
  void initState() {
    super.initState();
    this._fetchData();
  }
  int tot_question = 0;
  int tot_answer = 0;
  int tot_null = 0;
  int tot_good = 0;
  int tot_notgood = 0;
  String result = '';
  String no_sewa = '';
  String alat = '';
  String customer = '';
  String pic = '';
  Future _fetchData() async {
    print("fetch");
    // print(todo);
    var jsonResponse = null;
    final response =
        await http.get(url_root + "index.php?r=question/result&id="+id);
    print(response.statusCode);
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      // if (json.decode(response.body)['status'] != 0) {

      print("login ok");
      setState(() {
        tot_question = jsonResponse["tot_question"];
        tot_answer = jsonResponse["tot_answer"];
        tot_null = jsonResponse["tot_null"];
        tot_good = jsonResponse["tot_good"];
        tot_notgood = jsonResponse["tot_notgood"];
        result = jsonResponse["result"];
        no_sewa = jsonResponse["data"][0]["no_sewa"];
        alat = jsonResponse["data"][0]["alat"];
        customer = jsonResponse["data"][0]["customer"];
        pic = jsonResponse["data"][0]["pic"];
        // nosewa = jsonResponse["data"]["no_sewa"];
      });
      print("list");
    } else {
      throw Exception('Failed to load photos');
    }
  }

  final TextEditingController namaController = new TextEditingController();

  final TextEditingController remark = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    print(id);
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // actionsIconTheme: Colors.black,
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new QuestionList(),
                        settings: RouteSettings(arguments: todo)));
              }, // omitting onPressed makes the button disabled
            ),
          ),
          title: Text(
            "Result "+todo,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body:  no_sewa == '' ? Center(
                                          child: CircularProgressIndicator(),
                                        ) :SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text('Detail QC Inspection'),
     Divider(
                        color: Colors.green,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.pages,
                          color: Colors.green,
                        ),
                        title: Text("No Sewa"),
                        subtitle: Text(no_sewa),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text("alat"),
                        subtitle: Text(alat),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.yellow,
                        ),
                        title: Text("Customer"),
                        subtitle: Text(customer),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.person_add_alt,
                          color: Colors.brown,
                        ),
                        title: Text("PIC"),
                        subtitle: Text(pic),
                      ),
                      SizedBox(
                      height: size.height * 0.02,
                    ),
                      Text('Result QC Inspection'),
                      Divider(
                        color: Colors.green,
                      ),

                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: result == 'PASSED' ? Colors.green :  Colors.red,
                        ),
                        title: Text("Status"),
                        subtitle: Text(result, style: TextStyle(color:  result == 'PASSED' ? Colors.green :  Colors.red,fontWeight: FontWeight.bold), ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.label,
                          color: Colors.blue,
                        ),
                        title: Text("Question"),
                        subtitle: Text(tot_question.toString()),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.question_answer,
                          color: Colors.purple,
                        ),
                        title: Text("Answered"),
                        subtitle: Text(tot_answer.toString()),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.question_answer_outlined,
                          color: Colors.orange,
                        ),
                        title: Text("Not Answered Yet"),
                        subtitle: Text(tot_null.toString()),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        title: Text("GOOD"),
                        subtitle: Text(tot_good.toString()),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.grey,
                        ),
                        title: Text("NOT GOOD"),
                        subtitle: Text(tot_notgood.toString()),
                      ),
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
