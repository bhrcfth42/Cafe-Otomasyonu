import 'dart:convert';
import 'package:http/http.dart' as baglanti;

class Masa {
  Id iId;
  String masaAdi;
  List<SiparisList> siparisList;
  String masaDurumu;

  Masa({this.iId, this.masaAdi, this.siparisList,this.masaDurumu});

  Masa.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    masaAdi = json['masa_adi'];
    masaDurumu=json['masa_durumu'];
    if (json['siparisList'] != null) {
      siparisList = new List<SiparisList>();
      json['siparisList'].forEach((v) {
        siparisList.add(new SiparisList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['masa_adi'] = this.masaAdi;
    data['masa_durumu']=this.masaDurumu;
    if (this.siparisList != null) {
      data['siparisList'] = this.siparisList.map((v) => v.toJson()).toList();
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

class SiparisList {
  String urunAdi;
  int urunAdet;
  double urunFiyat;

  SiparisList({this.urunAdi, this.urunAdet,this.urunFiyat});

  SiparisList.fromJson(Map<String, dynamic> json) {
    urunAdi = json['urun_adi'];
    urunAdet = json['urun_adet'];
    urunFiyat = double.parse(json['urun_fiyat'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urun_adi'] = this.urunAdi;
    data['urun_adet'] = this.urunAdet;
    data['urun_fiyat']=this.urunFiyat;
    return data;
  }
}
Future<List<Masa>> postgetir() async{
  
  final cevap= await baglanti.get("http://192.168.1.10/mongophp/masalar.php");
  var list = json.decode(cevap.body.toString()) as List;
  List<Masa> masalar = list.map((i)=>Masa.fromJson(i)).toList();
  if(cevap.statusCode==200)
    return masalar;
  else
    throw Exception("Hata oluştu");
}