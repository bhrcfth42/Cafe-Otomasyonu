class Siparis {
  String id;
  List<SiparisList> siparisList=new List<SiparisList>();

  Siparis({this.id, this.siparisList});
}

class SiparisList {
  String siparisadi;
  int siparisadet;
  double siparisfiyat;

  SiparisList({this.siparisadi, this.siparisadet,this.siparisfiyat});
}
