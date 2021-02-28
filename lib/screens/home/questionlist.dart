import 'dart:convert';
import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:qc/main.dart';

import 'package:dio/dio.dart' as http_dio;
import 'package:http/http.dart' as http;
import 'package:qc/constants.dart';
import 'package:qc/models/question.dart';
import 'package:qc/screens/home/home_screen.dart';
import 'package:qc/screens/home/result.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({
    Key key,
  }) : super(key: key);
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  _QuestionListState({
    Key key,
  });
  final _formKey = GlobalKey<FormState>();

  var opsi = [
    "GOOD",
    "NOT GOOD",
  ];
  String opsi_select;
  http_dio.Dio dio = http_dio.Dio();
  Future<List<Question>> getQc() async {
    final todo = ModalRoute.of(context).settings.arguments;

    http_dio.Response response =
        await dio.get(url_root + "index.php?r=question/question&id=" + todo);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      final List rawData = jsonDecode(jsonEncode(response.data['data']));
      List<Question> listQuestion =
          rawData.map((f) => Question.fromJson(f)).toList();
      print(response.data);
      print("ok");
      return listQuestion;
    } else {
      print("gagal");
      return null;
    }
  }

  post(String id, result, remark) async {
    // sharedPreferences.clear();
    final todo = ModalRoute.of(context).settings.arguments;

    Map data = {
      'id_sewa': todo,
      'id_question': id,
      'result': result,
      'cek_inspection': remark
    };
    print(id);
    print('cek login');
    var response =
        await http.post(url_root + "index.php?r=question/answers", body: data);
    print(response.body);
    if (response.statusCode == 200) {
      print('start');
      if (json.decode(response.body)['status'] != 0) {
        print("login ok");
        Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new QuestionList(),
                      settings: RouteSettings(arguments: todo)));
      } else {
        print('gagal');
        info(context, json.decode(response.body)['message']);
        print(json.decode(response.body)['message']);
      }
    } else {
      print(response.body);
    }
  }

  void info(BuildContext context, String status) {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text(status),
    //   backgroundColor: Colors.red,
    //   duration: Duration(seconds: 3),
    // ));
    Flushbar(
      duration: Duration(seconds: 3),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Info!',
      message: status,
    ).show(context);
  }

  final TextEditingController namaController = new TextEditingController();

  final TextEditingController remark = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          // actionsIconTheme: Colors.black,
          leading: Padding(
            padding: EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()),
                    (Route<dynamic> route) => false);
                // runApp(MyApp());
              }, // omitting onPressed makes the button disabled
            ),
          ),
          title: Text(
            "Question List",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.article, color: Colors.amber),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ResultPage(id: todo),
                        settings: RouteSettings(arguments: todo)));
              }, // omitting onPressed makes the button disabled
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: getQc(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Question>> snapshots) {
              switch (snapshots.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshots.hasError) {
                    print("data not show recomende");
                    print(snapshots.data);
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    print("datas tertampilkan");
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshots.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: Text((index + 1).toString()),
                              // const Icon(Icons.flight_land),
                              title: Text(snapshots.data[index].question),
                              subtitle: snapshots.data[index].result == null
                                  ? Text('')
                                  : Text(snapshots.data[index].result),
                              trailing: snapshots.data[index].result == null
                                  ? Icon(Icons.add_circle_outline,
                                      color: Colors.green)
                                  : snapshots.data[index].result == 'GOOD'
                                      ? Icon(Icons.check_circle_outline,
                                          color: Colors.blue)
                                      : Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                        ),
                              onTap: snapshots.data[index].result == null
                                  ? () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          child: Container(
                                            height: size.height * 0.35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                key: _formKey,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Your Answer",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.05,
                                                    ),
                                                    Text(
                                                      (index + 1).toString() +
                                                          ". " +
                                                          snapshots.data[index]
                                                              .question,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .centerStart,
                                                      child: Text(
                                                        "remark :",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          // fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: remark,
                                                      decoration: InputDecoration(
                                                          // hintText: "Alamat Email Anda",
                                                          // labelText: "Alamat Email Anda"
                                                          ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter some text';
                                                        }
                                                      },
                                                    ),
                                                    Center(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    15.0,
                                                                    20.0,
                                                                    0.0,
                                                                    0.0),
                                                            child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              // height: 40.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                // border: Border.all(),
                                                                // color: Colors.black54,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child:
                                                                  RaisedButton
                                                                      .icon(
                                                                elevation: 4,
                                                                color: Colors
                                                                    .green,
                                                                onPressed:
                                                                    () async {
                                                                  post(
                                                                      snapshots
                                                                          .data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      "GOOD",
                                                                      remark
                                                                          .text);
                                                                },
                                                                icon:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  radius: 10.0,
                                                                  child:
                                                                      new Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 10.0,
                                                                  ),
                                                                ),
                                                                label: Center(
                                                                  child: Text(
                                                                    "GOOD",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0.0,
                                                                    20.0,
                                                                    15.0,
                                                                    0.0),
                                                            child: Container(
                                                              width:
                                                                  size.width *
                                                                      0.3,
                                                              // height: 40.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                // border: Border.all(),
                                                                // color: Colors.black54,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              child:
                                                                  RaisedButton
                                                                      .icon(
                                                                elevation: 4,
                                                                color:
                                                                    Colors.red,
                                                                onPressed:
                                                                    () async {
                                                                  post(
                                                                      snapshots
                                                                          .data[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      "NOT GOOD",
                                                                      remark
                                                                          .text);
                                                                },
                                                                icon:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  radius: 10.0,
                                                                  child:
                                                                      new Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 10.0,
                                                                  ),
                                                                ),
                                                                label: Center(
                                                                  child: Text(
                                                                    "NOT GOOD",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  : () async {});
                        },
                      ),
                    );

                    //
                  }

                  break;
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.id,
    this.alat,
    this.question,
    this.cat,
    this.press,
  }) : super(key: key);

  final String alat, question;
  final int id, cat;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          // Image.network(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$alat\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "Use at: $question",
                          style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    "$cat".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
