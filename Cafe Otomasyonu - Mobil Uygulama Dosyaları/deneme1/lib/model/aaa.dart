import 'dart:convert';
import 'package:http/http.dart' as baglanti;

class Aaa {
  String urunAdi;
  double urunFiyat;

  Aaa({this.urunAdi, this.urunFiyat});

  Aaa.fromJson(Map<String, dynamic> json) {
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

Future<List<Aaa>> postgetir(String ktadi) async{
  List<Aaa> list;
  final cevap= await baglanti.get("http://192.168.1.10/mongophp/urun.php?ktadi="+ktadi);
  var data = json.decode(cevap.body);
        var rest = data["urunList"] as List;
        list = rest.map<Aaa>((json) => Aaa.fromJson(json)).toList();
  if(cevap.statusCode==200)
    return list;
  else
    throw Exception("Hata oluştu");
}