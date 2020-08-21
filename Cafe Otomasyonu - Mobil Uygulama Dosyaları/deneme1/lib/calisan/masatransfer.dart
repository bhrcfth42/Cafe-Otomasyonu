import 'dart:io';
import 'package:http/http.dart' as baglanti;
import 'package:deneme1/model/masa.dart';
import 'package:flutter/material.dart';

class MasaTransfer extends StatefulWidget {
  @override
  _MasaTransferState createState() => _MasaTransferState();
}

class _MasaTransferState extends State<MasaTransfer> {
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

  Future<void> masatransfer() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pushNamed(context, "/calisanmenu"),
          ),
          title: Text("Masa Transfer Menü"),
          backgroundColor: Colors.lightBlue,
        ),
        body: Container(
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('http://192.168.1.10/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: AlignmentDirectional.topCenter,
            child: FutureBuilder<List<Masa>>(
              future: postgetir(),
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      if (snapshot.data[index].siparisList.isNotEmpty)
                        return Card(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(snapshot.data[index].masaAdi),
                                new GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: Center(
                                        child: Card(
                                          child: Container(
                                            child: FutureBuilder<List<Masa>>(
                                              future: postgetir(),
                                              builder: (context, snapshots) {
                                                if (snapshots.hasData)
                                                  return ListView.builder(
                                                    itemBuilder:
                                                        (context, indexx) {
                                                      if (snapshots.data[indexx]
                                                          .siparisList.isEmpty)
                                                        return Card(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Text(snapshots
                                                                    .data[
                                                                        indexx]
                                                                    .masaAdi),
                                                                new GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    final cevap =
                                                                        await baglanti
                                                                            .get("http://192.168.1.10/mongophp/masatransfer.php?masaadi1="+snapshot.data[index].masaAdi+"&masaadi2="+snapshots.data[indexx].masaAdi);
                                                                    if (cevap.statusCode ==
                                                                            200 &&
                                                                        cevap.body !=
                                                                            "Modified 0 document(s)") {
                                                                      return Navigator.pushNamed(
                                                                          context,
                                                                          "/calisanmenu");
                                                                    } else {
                                                                      return showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                new AlertDialog(
                                                                          title:
                                                                              Text("HATA"),
                                                                          content:
                                                                              Text("Masa transferi yapılamadı."),
                                                                          actions: <
                                                                              Widget>[
                                                                            new FlatButton(
                                                                                onPressed: () =>Navigator.of(context).pop(false),
                                                                                child: Text("Kapat"))
                                                                          ],
                                                                        ),
                                                                        barrierDismissible: false,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Icon(Icons
                                                                      .transfer_within_a_station),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      return Card(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .masaAdi,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount:
                                                        snapshot.data?.length ??
                                                            0,
                                                    shrinkWrap:
                                                        true, // todo comment this out and check the result
                                                    physics:
                                                        ClampingScrollPhysics(), // todo comment this out and check the result
                                                  );
                                                else if (snapshot.hasError)
                                                  return Text("Hata oluştu");
                                                return CircularProgressIndicator();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(Icons.transfer_within_a_station),
                                ),
                              ],
                            ),
                          ),
                        );
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                snapshot.data[index].masaAdi,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                    shrinkWrap:
                        true, // todo comment this out and check the result
                    physics:
                        ClampingScrollPhysics(), // todo comment this out and check the result
                  );
                else if (snapshot.hasError) return Text("Hata oluştu");
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
