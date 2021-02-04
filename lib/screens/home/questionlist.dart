import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qc/main.dart';

import 'package:dio/dio.dart' as http_dio;
import 'package:qc/constants.dart';
import 'package:qc/models/question.dart';

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
        await dio.get(url_root + "index.php?r=question/question&id=C-001");
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

  final TextEditingController namaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          // actionsIconTheme: Colors.black,
          title: Text(
            "Question List",
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
                              leading: Text((index+1).toString()),
                              // const Icon(Icons.flight_land),
                              title:  Text(snapshots.data[index].question),
                              subtitle:
                                  const Text('Result: Good'),
                              trailing:  Icon(Icons.check_circle_outline,color: Colors.blue,),
                              onTap: () => print("ListTile"));
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
