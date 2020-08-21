import 'dart:io';

import 'package:deneme1/model/ciro.dart';
import 'package:flutter/material.dart';

class CiroIslem extends StatefulWidget {
  @override
  _CiroIslemState createState() => _CiroIslemState();
}

class _CiroIslemState extends State<CiroIslem> {
  Future<bool> _onBackPressed() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Çıkış'),
            content:
                new Text('Uygulamadan çıkmak istediğinizden emin misiniz?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blueAccent[100],
                  child: Text(
                    "Hayır",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => exit(0),
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blueAccent[100],
                  child: Text(
                    "Evet",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pushNamed(context, "/calisanmenu"),
            ),
            title: Text("Ciro Menü"),
            backgroundColor: Colors.lightBlue,
          ),
          body: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image:
                    NetworkImage('http://192.168.1.10/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: AlignmentDirectional.topCenter,
              child: FutureBuilder<List<Ciro>>(
                  future: postgetir(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListView.builder(
                            itemBuilder: (context, indexx) {
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(snapshot.data[index].masaAdi),
                                      Text(snapshot.data[index].ciroList[indexx]
                                              .date.day
                                              .toString() +
                                          " / " +
                                          snapshot.data[index].ciroList[indexx]
                                              .date.month
                                              .toString() +
                                          " / " +
                                          snapshot.data[index].ciroList[indexx]
                                              .date.year
                                              .toString()),
                                      Text(snapshot
                                          .data[index].ciroList[indexx].gelir
                                          .toString()),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                snapshot.data[index].ciroList?.length ?? 0,
                            shrinkWrap:
                                true, // todo comment this out and check the result
                            physics: ClampingScrollPhysics(),
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0,
                        shrinkWrap:
                            true, // todo comment this out and check the result
                        physics:
                            ClampingScrollPhysics(), // todo comment this out and check the result
                      );
                    else if (snapshot.hasError) return Text("Hata oluştu");
                    return CircularProgressIndicator();
                  }),
            ),
          ),
        ),
        onWillPop: _onBackPressed);
  }
}
