import 'dart:io';
import 'dart:ui';

import 'package:deneme1/model/masa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as baglanti;
import 'package:qr_flutter/qr_flutter.dart';

class Masaislem extends StatefulWidget {
  @override
  _MasaislemState createState() => _MasaislemState();
}

class _MasaislemState extends State<Masaislem> {
  PageController _controller = PageController(
    initialPage: 0,
  );

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushNamed(context, "/calisanmenu"),
          ),
          title: Text("Masa İşlemleri"),
          backgroundColor: Colors.lightBlue,
        ),
        body: new PageView(
          controller: _controller,
          children: [
            MyPage1Widget(),
            MyPage2Widget(),
            MyPage3Widget(),
          ],
        ),
      ),
    );
  }
}

class MyPage1Widget extends StatefulWidget {
  @override
  _MyPage1WidgetState createState() => _MyPage1WidgetState();
}

class _MyPage1WidgetState extends State<MyPage1Widget> {
  var masaadi;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('http://192.168.1.10/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Center(
        child: FutureBuilder<List<Masa>>(
            future: postgetir(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data.map((masa) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Masa Adı: " + masa.masaAdi),
                            GestureDetector(
                              onTap: () => setState(() async {
                                masaadi = masa.masaAdi;
                                final cevap = await baglanti.get(
                                    "http://192.168.1.10/mongophp/masasil.php?masaadi=" +
                                        masaadi);
                                if (cevap.body != "Deleted 0 document(s)" &&
                                    cevap.statusCode == 200)
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Başarılı'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('Masa adı: ' +
                                                  masa.masaAdi +
                                                  ' başarı ile silindi.'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Tamam'),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  // Create the SelectionScreen in the next step.
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Masaislem()));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                else
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('HATA'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('Masa adı: ' +
                                                  masa.masaAdi +
                                                  ' Silinemedi.'),
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
                              }),
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) return Text("Hata oluştu");
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class MyPage2Widget extends StatefulWidget {
  @override
  _MyPage2WidgetState createState() => _MyPage2WidgetState();
}

class _MyPage2WidgetState extends State<MyPage2Widget> {
  final _formKey = GlobalKey<FormState>();
  String masaadi;
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage('http://192.168.1.10/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Form(
          key: _formKey,
          child: new Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        color: Colors.blueAccent[100],
                        padding: EdgeInsets.all(10),
                        child: new Text(
                          "Masa Kayıt Oluşturma",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Masa Adı',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Lütfen Boş Bırakmayınız';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          masaadi = value;
                        },
                      ),
                      new Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          splashColor: Colors.green,
                          onPressed: () async {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                              _formKey.currentState.save();

                              final cevap = await baglanti.get(
                                  "http://192.168.1.10/mongophp/masakayit.php?masaadi=" +
                                      masaadi);
                              if (cevap.body != "null" &&
                                  cevap.statusCode == 200)
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Başarılı'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Masa kaydı yapıldı.'),
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
                              else
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('HATA'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Masa kaydı Yapılamadı.'),
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
                            }
                          },
                          child: Text(
                            'Masayı Kaydet',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
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
    );
  }
}

class MyPage3Widget extends StatefulWidget {
  @override
  _MyPage3WidgetState createState() => _MyPage3WidgetState();
}

class _MyPage3WidgetState extends State<MyPage3Widget> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";
  Masa dropdownValue;

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage('http://192.168.1.10/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FutureBuilder<List<Masa>>(
                  future: postgetir(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return DropdownButton<Masa>(
                        icon: Icon(Icons.arrow_downward),
                        items: snapshot.data
                            .map((e) => DropdownMenuItem<Masa>(
                                  child: Text(
                                    e.masaAdi,
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (Masa value) {
                          setState(() {
                            dropdownValue = value;
                            _dataString = dropdownValue.iId.oid;
                          });
                        },
                        isExpanded: false,
                        hint: dropdownValue == null
                            ? Text("Masa Seçiniz")
                            : Text(
                                dropdownValue.masaAdi,
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                      );
                    else if (snapshot.hasError) return Text("Hata oluştu");
                    return CircularProgressIndicator();
                  }),
              Expanded(
                child: Center(
                  child: RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      data: _dataString,
                      size: 0.5 * bodyHeight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
