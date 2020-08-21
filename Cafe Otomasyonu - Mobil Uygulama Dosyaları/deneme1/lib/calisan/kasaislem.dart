import 'dart:io';

import 'package:deneme1/calisan/odeme.dart';
import 'package:deneme1/model/masa.dart';
import 'package:flutter/material.dart';

class Kasaislem extends StatefulWidget {
  @override
  _KasaislemState createState() => _KasaislemState();
}

class _KasaislemState extends State<Kasaislem> {
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
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushNamed(context, "/calisanmenu"),
          ),
          title: Text("Kasa İşlemleri"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            child: FutureBuilder<List<Masa>>(
                future: postgetir(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      primary: false,
                      padding: EdgeInsets.all(5),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(snapshot.data.length, (index) {
                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://192.168.1.10/images/masa.gif"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.topCenter,
                            child: new Transform(
                              alignment: Alignment.topCenter,
                              transform: Matrix4.skewY(0.0)..rotateZ(0.0),
                              child: new Container(
                                color: Colors.greenAccent[100],
                                padding: EdgeInsets.all(5.0),
                                child: new Text(
                                  'Masa Adı: ' + snapshot.data[index].masaAdi,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (snapshot.data[index].siparisList == null ||
                                snapshot.data[index].siparisList.length == 0)
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Hata"),
                                    content: Text("Sipariş Bulunamadı."),
                                    actions: <Widget>[
                                      new GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pop(true),
                                        child: new Container(
                                          padding: EdgeInsets.all(10.0),
                                          color: Colors.blueAccent[100],
                                          child: Text(
                                            "Tamam",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            else
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Odeme(
                                    masa: snapshot.data[index],
                                  ),
                                ),
                              );
                          },
                        );
                      }),
                    );
                  } else if (snapshot.hasError) return Text("Hata oluştu");
                  return CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }
}
