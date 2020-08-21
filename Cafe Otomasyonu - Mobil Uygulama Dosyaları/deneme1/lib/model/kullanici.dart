import 'dart:convert';
import 'package:http/http.dart' as baglanti;

class Kullanicilar {
  String id;
  String kullaniciadi;
  String parola;
  Kullanicilar({this.id,this.kullaniciadi,this.parola});
  factory Kullanicilar.fromJson(Map<String, dynamic> json){
    return Kullanicilar(
    kullaniciadi: json["kullanici_adi"],
    parola: json["parola"],
    );
  }
}
Future<List<Kullanicilar>> postgetir() async{
  
  final cevap= await baglanti.get("http://192.168.1.10/mongophp/kullanicilar.php");
  var list = json.decode(cevap.body) as List;
  List<Kullanicilar> kullanicilar = list.map((i)=>Kullanicilar.fromJson(i)).toList();
  if(cevap.statusCode==200)
    return kullanicilar;
  else
    throw Exception("Hata oluştu");
}