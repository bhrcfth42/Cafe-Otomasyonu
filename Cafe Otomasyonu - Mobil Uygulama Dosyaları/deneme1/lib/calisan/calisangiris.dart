import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as baglanti;

class CalisanGiris extends StatefulWidget {
  @override
  _CalisanGirisState createState() => _CalisanGirisState();
}

class _CalisanGirisState extends State<CalisanGiris> {
  final _formKey = GlobalKey<FormState>();
  String kullaniciadi;
  String sifre;

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
            onPressed: () => Navigator.pushNamed(context, "/"),
          ),
          title: Text("Çalışan Giriş"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  'http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Center(
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: new Form(
                key: _formKey,
                child: new Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v)=> FocusScope.of(context).nextFocus(),
                      ),
                      new TextFormField(
                        obscureText: true,
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
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (v)=> FocusScope.of(context).nextFocus(),
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
                                  "http://192.168.1.10/mongophp/kullanicisorgu.php?kadi=" +
                                      kullaniciadi +
                                      "&sifre=" +
                                      sifre);
                              if (cevap.body != "null" &&
                                  cevap.statusCode == 200)
                                Navigator.pushNamed(context, "/calisanmenu");
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
                                            Text(
                                                'Kullanıcı adı veya parola hatalı.'),
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
                            'Giriş',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
