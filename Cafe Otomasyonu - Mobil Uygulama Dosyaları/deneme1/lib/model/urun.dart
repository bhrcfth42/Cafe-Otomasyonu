import 'dart:convert';
import 'package:http/http.dart' as baglanti;

class Urun {
  Id iId;
  String kategoriAdi;
  List<UrunList> urunList;

  Urun({this.iId, this.kategoriAdi, this.urunList});

  Urun.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    kategoriAdi = json['kategori_adi'];
    if (json['urunList'] != null) {
      urunList = new List<UrunList>();
      json['urunList'].forEach((v) {
        urunList.add(new UrunList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['kategori_adi'] = this.kategoriAdi;
    if (this.urunList != null) {
      data['urunList'] = this.urunList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Id {
  String oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['\$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$oid'] = this.oid;
    return data;
  }
}

class UrunList {
  String urunAdi;
  double urunFiyat;

  UrunList({this.urunAdi, this.urunFiyat});

  UrunList.fromJson(Map<String, dynamic> json) {
    urunAdi = json['urun_adi'];
    urunFiyat = double.parse(json['urun_fiyat'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urun_adi'] = this.urunAdi;
    data['urun_fiyat'] = this.urunFiyat;
    return data;
  }
}

Future<List<Urun>> postgetir() async{
  
  final cevap= await baglanti.get("http://192.168.1.10/mongophp/urunler.php");
  var list = json.decode(cevap.body.toString()) as List;
  List<Urun> urunler = list.map((i)=>Urun.fromJson(i)).toList();
  if(cevap.statusCode==200)
    return urunler;
  else
    throw Exception("Hata oluştu");
}