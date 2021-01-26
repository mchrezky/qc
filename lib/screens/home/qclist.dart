import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qc/main.dart';

import 'package:dio/dio.dart' as http_dio;
import 'package:http/http.dart' as http;
import 'package:qc/constants.dart';
import 'package:qc/models/sewa.dart';

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
    final todo = ModalRoute.of(context).settings.arguments;

    http_dio.Response response =
        await dio.get(url_root + "index.php?r=sewa/qc-pic&id=3");
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
                            alat: snapshot.data[index].noAlat,
                            tgl: snapshot.data[index].tglSewa,
                            cust: snapshot.data[index].idCustomer,
                            press: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailsScreen(),
                              //   ),
                              // );
                            },
                          ),
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
    this.tgl,
    this.cust,
    this.press,
  }) : super(key: key);

  final String image, alat, tgl;
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
                          text: "Use at: $tgl",
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
                   "$cust".toUpperCase(),
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
