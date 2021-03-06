import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qc/main.dart';

import 'package:dio/dio.dart' as http_dio;
import 'package:http/http.dart' as http;
import 'package:qc/constants.dart';
import 'package:qc/models/sewa.dart';
import 'package:qc/screens/home/questionlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QcList extends StatefulWidget {
  const QcList({
    Key key,
  }) : super(key: key);
  @override
  _QcListState createState() => _QcListState();
}

class _QcListState extends State<QcList> {
  _QcListState({
    Key key,
  });
  http_dio.Dio dio = http_dio.Dio();
  Future<List<Sewa>> getQc() async {
    print("qc-pic");
     SharedPreferences prefs = await SharedPreferences.getInstance();
     int id = (prefs.getInt('id') ?? false);
     print(id);

    http_dio.Response response =
        await dio.get(url_root + "index.php?r=sewa/qc-pic&id="+id.toString());
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      final List rawData = jsonDecode(jsonEncode(response.data));
      List<Sewa> listSewa = rawData.map((f) => Sewa.fromJson(f)).toList();
      print(response.data);
      print("ok");
      return listSewa;
    } else {
      print("gagal");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getQc(),
      builder: (BuildContext context, AsyncSnapshot<List<Sewa>> snapshot) {
        switch (snapshot.connectionState) {
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
            print("satu");
            print(snapshot.hasData);
            if (snapshot.hasError) {
              // return Container(
              //     color: Colors.white,
              //     child: Center(
              //         child: new Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         new Text("Network Connection Error\n\n"),
              //         new FlatButton.icon(
              //           // padding: EdgeInsets.all(10.0),
              //           // color: Colors.greenAccent,
              //           icon: CircleAvatar(
              //             backgroundColor: Colors.blue,
              //             radius: 20.0,
              //             child: new Icon(
              //               Icons.refresh,
              //               color: Colors.white,
              //               size: 30.0,
              //             ),
              //           ),
              //           label: Text(""),
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => HomeScreen(),
              //                 ));
              //           },
              //         ),
              //         // new Icon(
              //         //   Icons.refresh,
              //         //   color: Colors.blue,
              //         // ),
              //         new Text("\nRefresh  " + snapshot.hasError.toString(),
              //             style:
              //                 new TextStyle(fontSize: 25, color: Colors.blue))
              //       ],
              //     )));
            } else {
              //list ikan
              print("tampilkan data");
              print(snapshot.data.length);
              print(snapshot.data);
              return Container(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: <Widget>[
                          RecomendPlantCard(
                            image:
                                "https://amanahamarta.com/wp-content/uploads/2018/12/segue-blog-whatis-quality-control-as-service.png",
                            alat: snapshot.data[index].alat,
                            id: snapshot.data[index].noSewa,
                            tgl: snapshot.data[index].tglSewa,
                            cust: snapshot.data[index].customer,
                            press: null,
                          )
                        ],
                      );
                    }),
              );
              // ListView.builder(
              //         scrollDirection: Axis.vertical,
              //         shrinkWrap: true,
              //         itemCount: snapshot.data.length,
              //         itemBuilder: (context, index) {
              //           return Row(
              //               children: <Widget>[
              //                 RecomendPlantCard(
              //                   image:
              //                       "https://amanahamarta.com/wp-content/uploads/2018/12/segue-blog-whatis-quality-control-as-service.png",
              //                   title: "Cakalang",
              //                   country: "Pelagis Besar",
              //                   cust: 440,
              //                   press: () {
              //                     // Navigator.push(
              //                     //   context,
              //                     //   MaterialPageRoute(
              //                     //     builder: (context) => DetailsScreen(),
              //                     //   ),
              //                     // );
              //                   },
              //                 ),
              //               ],

              //           );
              //         });
            }
            break;
        }
        return Container();
      },
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.alat,
    this.id,
    this.tgl,
    this.cust,
    this.press,
  }) : super(key: key);

  final String image,id, alat, tgl;
  final String cust;
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
          Image.network(image),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new QuestionList(),
                      settings: RouteSettings(arguments: id)));
            },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$alat".toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  ),
                  Text(
                    "$cust".toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                          style: TextStyle(
                            fontSize: 11,
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
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
