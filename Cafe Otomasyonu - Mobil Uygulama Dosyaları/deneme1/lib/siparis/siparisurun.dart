import 'dart:io';

import 'package:deneme1/model/aaa.dart';
import 'package:deneme1/model/siparis.dart';
import 'package:deneme1/siparis/sepet.dart';
import 'package:deneme1/siparis/siparismenu.dart';
import 'package:flutter/material.dart';

class SiparisUrun extends StatefulWidget {
  final String ktadi;
  final Siparis siparis;
  SiparisUrun({Key key, this.siparis, this.ktadi}) : super(key: key);

  @override
  _SiparisUrunState createState() => _SiparisUrunState();
}

class _SiparisUrunState extends State<SiparisUrun> {
  final _formKey = GlobalKey<FormState>();
  int adet;

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SiparisMenu(
                    siparis: widget.siparis,
                  ),
                ),
              ),
            ),
            title: Text("Ürün Seçimi"),
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
                image:
                    NetworkImage('http://192.168.1.10/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Center(
              child: FutureBuilder<List<Aaa>>(
                  future: postgetir(widget.ktadi) ?? 0,
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
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
                                      snapshot.data[index].urunAdi +
                                          '\n' +
                                          snapshot.data[index].urunFiyat
                                              .toString() +
                                          ' TL',
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
                                return showDialog(
                                  context: context,
                                  child: Center(
                                    child: Card(
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
                                                  "Ürün Adet",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              new TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Ürün Adet',
                                                ),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Lütfen Boş Bırakmayınız';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  adet = int.parse(value);
                                                },
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            new Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child:
                                                                  RaisedButton(
                                                                color: Colors
                                                                    .blueAccent,
                                                                splashColor:
                                                                    Colors
                                                                        .green,
                                                                onPressed:
                                                                    () async {
                                                                  // Validate will return true if the form is valid, or false if
                                                                  // the form is invalid.
                                                                  if (_formKey
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKey
                                                                        .currentState
                                                                        .save();
                                                                    if (widget
                                                                            .siparis
                                                                            .siparisList ==
                                                                        null)
                                                                      widget.siparis
                                                                              .siparisList =
                                                                          new List<
                                                                              SiparisList>();
                                                                    for (var i =
                                                                            0;
                                                                        i < widget.siparis.siparisList.length;
                                                                        i++) {
                                                                      if (widget
                                                                              .siparis
                                                                              .siparisList[
                                                                                  i]
                                                                              .siparisadi ==
                                                                          snapshot
                                                                              .data[index]
                                                                              .urunAdi) {
                                                                        widget
                                                                            .siparis
                                                                            .siparisList[i]
                                                                            .siparisadet += adet;
                                                                        Navigator.of(context)
                                                                            .pop(true);
                                                                        return;
                                                                      }
                                                                    }
                                                                    widget.siparis.siparisList.add(new SiparisList(
                                                                        siparisadi: snapshot
                                                                            .data[
                                                                                index]
                                                                            .urunAdi,
                                                                        siparisadet:
                                                                            adet,
                                                                        siparisfiyat: snapshot
                                                                            .data[index]
                                                                            .urunFiyat));
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Kaydet',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                            new Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child:
                                                                  RaisedButton(
                                                                color: Colors
                                                                    .blueAccent,
                                                                splashColor:
                                                                    Colors
                                                                        .green,
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  'Kapat',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                            ),
                          );
                        }).toList(),
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
