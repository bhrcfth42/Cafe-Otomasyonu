import 'dart:io';

import 'package:deneme1/model/siparis.dart';
import 'package:deneme1/siparis/siparismenu.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as baglanti;

class Anamenu extends StatefulWidget {
  @override
  _AnamenuState createState() => _AnamenuState();
}

class _AnamenuState extends State<Anamenu> {
  String barcode = "";

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
          title: Text("Cafe"),
          backgroundColor: Colors.lightBlue,
          leading: GestureDetector(
            onTap: _onBackPressed,
            child: Icon(Icons.exit_to_app),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: new GridView.count(
              primary: false,
              padding: EdgeInsets.all(5),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.width /
                  ((MediaQuery.of(context).size.height - 100) / 2),
              children: <Widget>[
                new GestureDetector(
                  onTap: scan,
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/siparis.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: new Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.skewY(0.0)..rotateZ(0.0),
                      child: new Container(
                        color: Colors.greenAccent[100],
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "Sipariş Menü",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/calisangiris"),
                  child: new Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "http://192.168.1.10/images/calisan.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: new Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.skewY(0.0)..rotateZ(0.0),
                      child: new Container(
                        color: Colors.greenAccent[100],
                        padding: EdgeInsets.all(10.0),
                        child: new Text(
                          "Çalışan Menü",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
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
      onWillPop: _onBackPressed,
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      final cevap = await baglanti
          .get("http://192.168.1.10/mongophp/masasorgu.php?id=" + this.barcode);
      if (cevap.body != "" && cevap.statusCode == 200) {
        final siparis =
            Siparis(id: barcode, siparisList: new List<SiparisList>());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SiparisMenu(
              siparis: siparis,
            ),
          ),
        );
      } else
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('HATA'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Masa Bulunamadı.'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
