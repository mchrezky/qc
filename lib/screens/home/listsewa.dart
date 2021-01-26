import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:rezkyshti/api/models/Sewa.dart';

import 'package:dio/dio.dart' as http_dio;
import 'package:http/http.dart' as http;
import 'package:qc/constants.dart';
import 'package:qc/main.dart';
import 'package:qc/models/sewa.dart';
import 'package:qc/screens/home/home_screen.dart';

class ListSewa extends StatefulWidget {
  const ListSewa({
    Key key,
  }) : super(key: key);
  @override
  _ListSewaState createState() => _ListSewaState();
}

class _ListSewaState extends State<ListSewa> {
  _ListSewaState({
    Key key,
  });
  http_dio.Dio dio = http_dio.Dio();
  Future<List<Sewa>> getHistory() async {
    final todo = ModalRoute.of(context).settings.arguments;
   
    
    http_dio.Response response = await dio.get(url_root + "index.php?r=sewa/get");
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      final List rawData = jsonDecode(jsonEncode(response.data));
      List<Sewa> listSewa =
          rawData.map((f) => Sewa.fromJson(f)).toList();
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
   
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FutureBuilder(
        future: getHistory(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Sewa>> snapshot) {
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
                return  SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FeaturePlantCard(
                        nosewa: snapshot.data[index].noSewa,
                        noalat: snapshot.data[index].noAlat,
                        customer: snapshot.data[index].idCustomer,
                        pic: snapshot.data[index].namaPic,
                      );
                    })
                );
              }
              break;
          }
          return Container();
        },
      ),
    );
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    Key key,
    this.nosewa,
    this.noalat,
    this.customer,
    this.pic,
  }) : super(key: key);
  final String nosewa;
  final String noalat;
  final String customer;
  final String pic;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 1,
      ),
      width: size.width * 2.4,
      child: Column(
        children: <Widget>[
          // Image.asset(image),
          GestureDetector(
            // onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                //  only(
                //   bottomLeft: Radius.circular(10),
                //   bottomRight: Radius.circular(10),
                // ),
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
                            text: "No Sewa : $nosewa \n".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: kPrimaryColor)),
                        TextSpan(
                            text: "Customer : $customer\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: " Pic : $pic".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$noalat',
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
