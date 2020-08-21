import 'dart:io';
import 'package:deneme1/model/siparis.dart';
import 'package:deneme1/siparis/siparismenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baglanti;

class Sepet extends StatefulWidget {
  final Siparis siparis;
  Sepet({Key key, @required this.siparis}) : super(key: key);
  @override
  _SepetState createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
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
    for (var i = 0; i < widget.siparis.siparisList.length; i++) {
      toplam += widget.siparis.siparisList[i].siparisadet *
          widget.siparis.siparisList[i].siparisfiyat;
    }

    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              List<SiparisList> onaylananlar = new List<SiparisList>();
              while (0 != widget.siparis.siparisList.length) {
                final cevap = await baglanti.get(
                    "http://192.168.1.10/mongophp/masasipariskayit.php?id=" +
                        widget.siparis.id +
                        "&uadi=" +
                        widget.siparis.siparisList[0].siparisadi +
                        "&uadet=" +
                        widget.siparis.siparisList[0].siparisadet.toString()+
                        "&ufyt=" + widget.siparis.siparisList[0].siparisfiyat.toString());
                if (cevap.body != "Modified 0 document(s)" &&
                    cevap.statusCode == 200) {
                  setState(() {
                    onaylananlar.add(widget.siparis.siparisList[0]);
                    widget.siparis.siparisList.removeAt(0);
                  });
                }
              }
              return showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: Text("Sipariş Listeniz"),
                  content: new Text(
                      "Onaylanan Sipariş Sayısı: ${onaylananlar.length}\nOnaylanmayan Sipariş Sayısı: ${widget.siparis.siparisList.length}"),
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
                ),
              );
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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SiparisMenu(
                    siparis: widget.siparis,
                  ),
                ),
              ),
            ),
            title: Text("Sepet"),
            backgroundColor: Colors.lightBlue,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'http://192.168.1.10/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
                itemCount: widget.siparis.siparisList.length,
                itemBuilder: (context, index) {
                  if (widget.siparis.siparisList != null)
                    return Card(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Ürün Adı: " +
                                      widget.siparis.siparisList[index]
                                          .siparisadi),
                                  Text("Adet: " +
                                      widget.siparis.siparisList[index]
                                          .siparisadet
                                          .toString()),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.siparis.siparisList
                                            .removeAt(index);
                                      });
                                    },
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  else if (widget.siparis.siparisList == null ||
                      widget.siparis.siparisList.length == 0)
                    return Text("Hata oluştu");
                  return CircularProgressIndicator();
                }),
          ),
        ),
        onWillPop: _onBackPressed);
  }
}
