import 'dart:io';

import 'package:deneme1/model/siparis.dart';
import 'package:deneme1/model/urun.dart';
import 'package:deneme1/siparis/sepet.dart';
import 'package:deneme1/siparis/siparisurun.dart';
import 'package:flutter/material.dart';

class SiparisMenu extends StatefulWidget {
  final Siparis siparis;
  SiparisMenu({Key key, @required this.siparis}) : super(key: key);

  @override
  _SiparisMenuState createState() => _SiparisMenuState();
}

class _SiparisMenuState extends State<SiparisMenu> {
  String barcode;

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
            onPressed: () => Navigator.pushNamed(context, "/"),
          ),
          title: Text("Kategori Seçimi"),
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sepet(
                      siparis: widget.siparis,
                    ),
                  ),
                ),
                child: Icon(Icons.local_grocery_store),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  'http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Center(
            child: new FutureBuilder<List<Urun>>(
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
                      return Card(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://192.168.1.10/images/yemek.gif"),
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
                                  'Kategori Adı: ' +
                                      snapshot.data[index].kategoriAdi,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SiparisUrun(
                                  siparis: widget.siparis,
                                  ktadi: snapshot.data[index].kategoriAdi,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) return Text("Hata oluştu");
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }
}
