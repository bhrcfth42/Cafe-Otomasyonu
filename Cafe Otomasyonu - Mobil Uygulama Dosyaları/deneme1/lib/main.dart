import 'package:deneme1/anasayfa/anasayfa.dart';
import 'package:deneme1/calisan/calisangiris.dart';
import 'package:deneme1/calisan/calisankullaniciislem.dart';
import 'package:deneme1/calisan/calisanmenu.dart';
import 'package:deneme1/calisan/ciroislem.dart';
import 'package:deneme1/calisan/kasaislem.dart';
import 'package:deneme1/calisan/masaislem.dart';
import 'package:deneme1/calisan/masatransfer.dart';
import 'package:deneme1/calisan/mutfak.dart';
import 'package:deneme1/calisan/urunislem.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cafe",
      home: Anamenu(),
      routes: {
        "/calisangiris": (context) => CalisanGiris(),
        "/calisanmenu": (context) => CalisanMenu(),
        "/calisankullaniciislem": (context) => Calisankullaniciislem(),
        "/masaislem": (context) => Masaislem(),
        "/urunislem": (context) => Urunislem(),
        "/kasaislem": (context) => Kasaislem(),
        "/ciroislem": (context) => CiroIslem(),
        "/masatransfer": (context) => MasaTransfer(),
        "/mutfak": (context) => Mutfak(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

void main()=>runApp(MyApp());

