import 'dart:async';
import 'dart:convert';
// Import the client from the Http Packages
import 'package:http/http.dart' as baglanti;

class Ciro {
  Id iId;
  String masaAdi;
  List<CiroList> ciroList;

  Ciro({this.iId, this.masaAdi, this.ciroList});

  Ciro.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    masaAdi = json['masa_adi'];
    if (json['CiroList'] != null) {
      ciroList = new List<CiroList>();
      json['CiroList'].forEach((v) {
        ciroList.add(new CiroList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    data['masa_adi'] = this.masaAdi;
    if (this.ciroList != null) {
      data['CiroList'] = this.ciroList.map((v) => v.toJson()).toList();
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

class CiroList {
  DateTime date;
  double gelir;

  CiroList({this.date, this.gelir});

  CiroList.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    gelir = double.parse(json['gelir'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['gelir'] = this.gelir;
    return data;
  }
}

Future<List<Ciro>> postgetir() async{
  final String baseUrl = "http://192.168.1.10/mongophp";
  final response = await baglanti.get("$baseUrl/cirolar.php");

  var list = json.decode(response.body) as List;
  List<Ciro> ciro = list.map((i)=>Ciro.fromJson(i)).toList();
     if (response.statusCode == 200) {
      return ciro;
    } else {
      return null;
    }
}
