import 'dart:io';

import 'package:deneme1/model/masa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baglanti;

class Mutfak extends StatefulWidget {
  @override
  _MutfakState createState() => _MutfakState();
}

class _MutfakState extends State<Mutfak> {
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
          title: Text("Mutfak"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: FutureBuilder<List<Masa>>(
                future: postgetir(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (snapshot.data[index].masaDurumu == "Onay Bekliyor")
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Text("Onay Bekleyen Masa ve Siparişleri"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data[index].masaAdi,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ListView.builder(
                                    itemBuilder: (context, indexx) {
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Ürün Adı = " +
                                                snapshot
                                                    .data[index]
                                                    .siparisList[indexx]
                                                    .urunAdi),
                                            Text("Ürün Adet = " +
                                                snapshot
                                                    .data[index]
                                                    .siparisList[indexx]
                                                    .urunAdet
                                                    .toString()),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount:
                                        snapshot.data[index].siparisList.length,
                                    shrinkWrap:
                                        true, // todo comment this out and check the result
                                    physics:
                                        ClampingScrollPhysics(), // todo comment this out and check the result
                                  ),
                                  FlatButton(
                                    child: Text("Onayla"),
                                    color: Colors.blueAccent,
                                    splashColor: Colors.green,
                                    onPressed: () async {
                                      final cevap = await baglanti.get(
                                          "http://192.168.1.10/mongophp/siparisonay.php?id=" +
                                              snapshot.data[index].iId.oid);
                                      if (cevap.body != "Modified 0 document(s)" &&
                                          cevap.statusCode == 200)
                                        return Navigator.pushNamed(context, "/mutfak");
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
                                                        'Masa Durumu Değiştirilemedi.'),
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
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        else if (snapshot.data[index].masaDurumu == "Onaylandı")
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Text("Onaylanmış Masa ve Siparişler"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(snapshot.data[index].masaAdi),
                                  ListView.builder(
                                    itemBuilder: (context, indexx) {
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("Ürün Adı = " +
                                                snapshot
                                                    .data[index]
                                                    .siparisList[indexx]
                                                    .urunAdi),
                                            Text("Ürün Adet = " +
                                                snapshot
                                                    .data[index]
                                                    .siparisList[indexx]
                                                    .urunAdet
                                                    .toString()),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount:
                                        snapshot.data[index].siparisList.length,
                                    shrinkWrap:
                                        true, // todo comment this out and check the result
                                    physics:
                                        ClampingScrollPhysics(), // todo comment this out and check the result
                                  ),
                                ],
                              ),
                            ),
                          );
                        else
                         return SizedBox();
                      },
                      itemCount: snapshot.data.length,
                      shrinkWrap:
                          true, // todo comment this out and check the result
                      physics:
                          ClampingScrollPhysics(), // todo comment this out and check the result
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
