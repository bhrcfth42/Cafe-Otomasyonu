import 'dart:io';

import 'package:deneme1/model/masa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baglanti;

class Odeme extends StatefulWidget {
  final Masa masa;
  Odeme({Key key, @required this.masa}) : super(key: key);
  @override
  _OdemeState createState() => _OdemeState();
}

class _OdemeState extends State<Odeme> {
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
    double toplam = 0;
    for (var i = 0; i < widget.masa.siparisList.length; i++) {
      toplam += widget.masa.siparisList[i].urunAdet *
          widget.masa.siparisList[i].urunFiyat;
    }
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final cevap = await baglanti.get(
                  "http://192.168.1.10/mongophp/ciroekleme.php?masaadi=" +
                      widget.masa.masaAdi +
                      "&gelir=" +
                      toplam.toString()+"&komut="+1.toString());
              if (cevap.body != "Modified 0 document(s)" &&
                  cevap.statusCode == 200) {
                return Navigator.pushNamed(context, "/kasaislem");
              } else
                return AlertDialog(
                  title: Text("Hata"),
                  content: Text("Sipariş Hesabı Kapanamadı."),
                  actions: <Widget>[
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: new Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.blueAccent[100],
                        child: Text(
                          "Tamam",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              // Ürün ciro veri tabanı konusunda işlem komutu eklenecek
            },
            child: Icon(Icons.attach_money),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 100.0,
              child: Center(
                child: Text("Toplam Fiyat: ${toplam.toString()} TL"),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pushNamed(context, "/kasaislem"),
            ),
            title: Text(widget.masa.masaAdi + " Ödeme İşlemleri"),
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
            child: ListView.builder(
                itemCount: widget.masa.siparisList.length,
                itemBuilder: (context, index) {
                  if (widget.masa.siparisList != null) {
                    return Card(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Ürün Adı: " +
                                      widget.masa.siparisList[index].urunAdi),
                                  Text("Adet: " +
                                      widget.masa.siparisList[index].urunAdet
                                          .toString()),
                                  GestureDetector(
                                    onTap: () async {
                                      // Ürün ciro veri tabanı konusunda işlem komutu eklenecek
                                      if (widget.masa.siparisList[index]
                                              .urunAdet ==
                                          1) {
                                        final cevap = await baglanti.get(
                                            "http://192.168.1.10/mongophp/masasiparissil.php?ad=" +
                                                widget.masa.masaAdi +
                                                "&uadi=" +
                                                widget.masa.siparisList[index]
                                                    .urunAdi +
                                                "&uadet=" +
                                                widget.masa.siparisList[index]
                                                    .urunAdet
                                                    .toString());
                                        if (cevap.body !=
                                                "Deleted 0 document(s)" &&
                                            cevap.statusCode == 200) {
                                          await baglanti.get(
                                              "http://192.168.1.10/mongophp/ciroekleme.php?masaadi=" +
                                                  widget.masa.masaAdi +
                                                  "&gelir=" +
                                                  widget.masa.siparisList[index]
                                                      .urunFiyat
                                                      .toString());
                                          setState(() {
                                            widget.masa.siparisList
                                                .removeAt(index);
                                          });
                                        } else
                                          return showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Hata"),
                                                content:
                                                    Text("Sipariş Silinemedi."),
                                                actions: <Widget>[
                                                  new GestureDetector(
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: new Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      color: Colors
                                                          .blueAccent[100],
                                                      child: Text(
                                                        "Tamam",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                      } else {
                                        int adet = widget
                                            .masa.siparisList[index].urunAdet;
                                        adet -= 1;
                                        final cevap = await baglanti.get(
                                            "http://192.168.1.10/mongophp/masatektekalma.php?ad=" +
                                                widget.masa.masaAdi +
                                                "&uadi=" +
                                                widget.masa.siparisList[index]
                                                    .urunAdi +
                                                "&uadet=" +
                                                adet.toString());
                                        if (cevap.body !=
                                                "Modified 0 document(s)" &&
                                            cevap.statusCode == 200) {
                                          await baglanti.get(
                                              "http://192.168.1.10/mongophp/ciroekleme.php?masaadi=" +
                                                  widget.masa.masaAdi +
                                                  "&gelir=" +
                                                  widget.masa.siparisList[index]
                                                      .urunFiyat
                                                      .toString());
                                          setState(() {
                                            widget.masa.siparisList[index]
                                                .urunAdet -= 1;
                                          });
                                        } else
                                          return showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Hata"),
                                                content: Text(
                                                    "Sipariş Adet Eksilmedi."),
                                                actions: <Widget>[
                                                  new GestureDetector(
                                                    onTap: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: new Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      color: Colors
                                                          .blueAccent[100],
                                                      child: Text(
                                                        "Tamam",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                      }
                                    },
                                    child: Icon(Icons.attach_money),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final cevap = await baglanti.get(
                                          "http://192.168.1.10/mongophp/masasiparissil.php?ad=" +
                                              widget.masa.masaAdi +
                                              "&uadi=" +
                                              widget.masa.siparisList[index]
                                                  .urunAdi +
                                              "&uadet=" +
                                              widget.masa.siparisList[index]
                                                  .urunAdet
                                                  .toString());
                                      if (cevap.body !=
                                              "Deleted 0 document(s)" &&
                                          cevap.statusCode == 200) {
                                        setState(() {
                                          widget.masa.siparisList
                                              .removeAt(index);
                                        });
                                      } else
                                        return showDialog(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Hata"),
                                              content:
                                                  Text("Sipariş Silinemedi."),
                                              actions: <Widget>[
                                                new GestureDetector(
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: new Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    color:
                                                        Colors.blueAccent[100],
                                                    child: Text(
                                                      "Tamam",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ),
        onWillPop: _onBackPressed);
  }
}
