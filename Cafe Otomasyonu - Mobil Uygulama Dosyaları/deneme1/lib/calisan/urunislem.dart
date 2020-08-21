import 'dart:io';

import 'package:deneme1/model/urun.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baglanti;

class Urunislem extends StatefulWidget {
  @override
  _UrunislemState createState() => _UrunislemState();
}

class _UrunislemState extends State<Urunislem> {
  PageController _controller;

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
      child: new Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushNamed(context, "/calisanmenu"),
          ),
          title: Text("Ürün İşlemleri"),
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
  final _formKey = GlobalKey<FormState>();
  double fiyat;
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
        child: new FutureBuilder<List<Urun>>(
          future: postgetir(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: new Column(
                        children: <Widget>[
                          Text(
                            'Kategori Adı: ' + snapshot.data[index].kategoriAdi,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          ListView.builder(
                            itemBuilder: (context, j) {
                              return Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Ürün Adı: ' +
                                              snapshot.data[index].urunList[j]
                                                  .urunAdi,
                                          style:
                                              Theme.of(context).textTheme.bodyText1,
                                        ),
                                        Text(
                                          'Fiyat ' +
                                              snapshot.data[index].urunList[j]
                                                  .urunFiyat
                                                  .toString(),
                                          style:
                                              Theme.of(context).textTheme.bodyText1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            return showDialog(
                                              context: context,
                                              child: Center(
                                                child: Card(
                                                  child: new Form(
                                                    key: _formKey,
                                                    child: new Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          new Container(
                                                            color: Colors
                                                                    .blueAccent[
                                                                100],
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: new Text(
                                                              "Ürün Fiyat Değiştirme",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          new TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'Ürün Fiyat',
                                                            ),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Lütfen Boş Bırakmayınız';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (value) {
                                                              fiyat =
                                                                  double.parse(
                                                                      value);
                                                            },
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        new Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(5),
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            splashColor:
                                                                                Colors.green,
                                                                            onPressed:
                                                                                () async {
                                                                              // Validate will return true if the form is valid, or false if
                                                                              // the form is invalid.
                                                                              if (_formKey.currentState.validate()) {
                                                                                // Process data.
                                                                                _formKey.currentState.save();
                                                                                final cevap = await baglanti.get("http://192.168.1.10/mongophp/urunfiyat.php?ktadi=" + snapshot.data[index].kategoriAdi + "&uadi=" + snapshot.data[index].urunList[j].urunAdi + "&ufyt=" + fiyat.toString());
                                                                                if (cevap.body != 'Modified 0 document(s)' && cevap.statusCode == 200)
                                                                                  return showDialog<void>(
                                                                                    context: context,
                                                                                    barrierDismissible: false, // user must tap button!
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text('Başarılı'),
                                                                                        content: SingleChildScrollView(
                                                                                          child: ListBody(
                                                                                            children: <Widget>[
                                                                                              Text('Ürün adı: ${snapshot.data[index].urunList[j].urunAdi}\nFiyat: $fiyat\nBaşarılı şekilde güncellendi.'),
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
                                                                                    barrierDismissible: false, // user must tap button!
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        title: Text('HATA'),
                                                                                        content: SingleChildScrollView(
                                                                                          child: ListBody(
                                                                                            children: <Widget>[
                                                                                              Text('Ürün Güncellenemedi.'),
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
                                                                            child:
                                                                                Text(
                                                                              'Kaydet',
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        new Padding(
                                                                          padding:
                                                                              EdgeInsets.all(5),
                                                                          child:
                                                                              RaisedButton(
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            splashColor:
                                                                                Colors.green,
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Kapat',
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.attach_money),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // Validate will return true if the form is valid, or false if
                                            // the form is invalid.
                                            final cevap = await baglanti.get(
                                                "http://192.168.1.10/mongophp/urunsil.php?ktadi=" +
                                                    snapshot.data[index]
                                                        .kategoriAdi +
                                                    "&uadi=" +
                                                    snapshot.data[index]
                                                        .urunList[j].urunAdi +
                                                    "&ufyt=" +
                                                    snapshot.data[index]
                                                        .urunList[j].urunFiyat
                                                        .toString());
                                            if (cevap.body !=
                                                    "Modified 0 document(s)" &&
                                                cevap.statusCode == 200)
                                              return showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Başarılı'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Ürün adı: ${snapshot.data[index].urunList[j].urunAdi}\nFiyat: ${snapshot.data[index].urunList[j].urunFiyat.toString()}\nBaşarılı şekilde Silindi.'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Tamam'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('HATA'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Ürün Silinemedi.'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('Tamam'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                          },
                                          child: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshot.data[index].urunList.length,
                            shrinkWrap:
                                true, // todo comment this out and check the result
                            physics:
                                ClampingScrollPhysics(), // todo comment this out and check the result
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else if (snapshot.hasError) return Text("Hata oluştu");
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class MyPage2Widget extends StatefulWidget {
  final List value;

  MyPage2Widget({Key key, this.value}) : super(key: key);
  @override
  _MyPage2WidgetState createState() => _MyPage2WidgetState();
}

class _MyPage2WidgetState extends State<MyPage2Widget> {
  String kategoriadi;
  final _formKey = GlobalKey<FormState>();
  String urunadi;
  double fiyat;
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
        child: FutureBuilder<List<Urun>>(
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
                        onTap: () async {
                          setState(() {
                            return showDialog(
                              context: context,
                              child: Center(
                                child: new Card(
                                  child: new Container(
                                    child: new Form(
                                      key: _formKey,
                                      child: new Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(
                                              color: Colors.blueAccent[100],
                                              padding: EdgeInsets.all(10),
                                              child: new Text(
                                                "Ürün Kayıt Oluşturma",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            new TextFormField(
                                              decoration: const InputDecoration(
                                                hintText: 'Ürün Adı',
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Lütfen Boş Bırakmayınız';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                urunadi = value;
                                              },
                                            ),
                                            new TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: 'Ürün Fiyat',
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Lütfen Boş Bırakmayınız';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                fiyat = double.parse(value);
                                              },
                                            ),
                                            new Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: RaisedButton(
                                                color: Colors.blueAccent,
                                                splashColor: Colors.green,
                                                onPressed: () async {
                                                  // Validate will return true if the form is valid, or false if
                                                  // the form is invalid.
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    // Process data.
                                                    _formKey.currentState
                                                        .save();
                                                    final cevap = await baglanti.get(
                                                        "http://192.168.1.10/mongophp/urunkayit.php?ktadi=" +
                                                            snapshot.data[index]
                                                                .kategoriAdi +
                                                            "&uadi=" +
                                                            urunadi +
                                                            "&ufyt=" +
                                                            fiyat.toString());
                                                    if (cevap.body !=
                                                            "Modified 0 document(s)" &&
                                                        cevap.statusCode == 200)
                                                      return showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Başarılı'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Ürün adı: $urunadi\nFiyat: $fiyat\nBaşarılı şekilde kaydedildi.'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text(
                                                                    'Tamam'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
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
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text('HATA'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Ürün Kaydedilemedi.'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text(
                                                                    'Tamam'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            new Padding(
                                              padding: EdgeInsets.all(5),
                                              child: RaisedButton(
                                                color: Colors.blueAccent,
                                                splashColor: Colors.green,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Kapat',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                            );
                          });
                        },
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

class MyPage3Widget extends StatefulWidget {
  @override
  _MyPage3WidgetState createState() => _MyPage3WidgetState();
}

class _MyPage3WidgetState extends State<MyPage3Widget> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String kategoriadi;
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
                          "Yeni Kategori Oluşturma",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Kategori Adı',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Lütfen Boş Bırakmayınız';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          kategoriadi = value;
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
                                  "http://192.168.1.10/mongophp/urunkategorikayit.php?kategoriadi=" +
                                      kategoriadi);
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
                                            Text('Kategori oluşturma başarı ile yapıldı.'),
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
                                            Text('Kategori oluşturulamadı.'),
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
