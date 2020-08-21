import 'dart:io';

import 'package:flutter/material.dart';
import 'package:deneme1/model/kullanici.dart';
import 'package:http/http.dart' as baglanti;

class Calisankullaniciislem extends StatefulWidget {
  @override
  _CalisankullaniciislemState createState() => _CalisankullaniciislemState();
}

class _CalisankullaniciislemState extends State<Calisankullaniciislem> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          title: Text("Kullanıcı İşlemleri"),
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
  var kadi, sifre;
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
        child: FutureBuilder<List<Kullanicilar>>(
            future: postgetir(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data.map((kullanici) {
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Kullanıcı Adı: " +
                                      kullanici.kullaniciadi),
                                  Text("Parola: " + kullanici.parola),
                                  GestureDetector(
                                    onTap: () => setState(() async {
                                      kadi = kullanici.kullaniciadi;
                                      sifre = kullanici.parola;
                                      final cevap = await baglanti.get(
                                          "http://192.168.1.10/mongophp/kullanicisil.php?kadi=" +
                                              kadi +
                                              "&sifre=" +
                                              sifre);
                                      if (cevap.body != "null" &&
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
                                                    Text('Kullanıcı adı: ' +
                                                        kullanici.kullaniciadi +
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
                                                                Calisankullaniciislem()));
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
                                                    Text('Kullanıcı adı: ' +
                                                        kullanici.kullaniciadi +
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
                            ],
                          ),
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
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String kullaniciadi;
    String sifre;
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
                          "Kullanıcı Kayıt Oluşturma",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Kullanıcı Adı',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Lütfen Boş Bırakmayınız';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          kullaniciadi = value;
                        },
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Şifre',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Lütfen Boş Bırakmayınız';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          sifre = value;
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
                                  "http://192.168.1.10/mongophp/kullanicikayit.php?kadi=" +
                                      kullaniciadi +
                                      "&sifre=" +
                                      sifre);
                              if (cevap.body != "Inserted 0 document(s)" &&
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
                                            Text('Kullanıcı kaydı yapıldı.'),
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
                                            Text('Kullanıcı kaydı Yapılamadı.'),
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
                            'Kaydet',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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

class MyPage3Widget extends StatefulWidget {
  @override
  _MyPage3WidgetState createState() => _MyPage3WidgetState();
}

class _MyPage3WidgetState extends State<MyPage3Widget> {
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
        child: Text("3.Sayfa"),
      ),
    );
  }
}
