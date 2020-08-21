import 'dart:io';

import 'package:flutter/material.dart';

class CalisanMenu extends StatefulWidget {
  @override
  _CalisanMenuState createState() => _CalisanMenuState();
}

class _CalisanMenuState extends State<CalisanMenu> {
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
            onPressed: () => Navigator.pushNamed(context, "/calisangiris"),
          ),
          title: Text("Çalışan Menü"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image:
                  NetworkImage('http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: new GridView.count(
              primary: false,
              padding: EdgeInsets.all(5),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                new GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, "/calisankullaniciislem"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/kullanici.gif"),
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
                          "Kullanıcı İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/masaislem"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("http://192.168.1.10/images/masa.gif"),
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
                          "Masa İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/urunislem"),
                  child: new Container(
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
                          "Ürün İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/kasaislem"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/kasa.gif"),
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
                          "Kasa İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/ciroislem"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/kasa.gif"),
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
                          "Ciro İşlemleri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/masatransfer"),
                  child: new Container(
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
                          "Masa Transfer İşlemi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/mutfak"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/kasa.gif"),
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
                          "Mutfak",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
