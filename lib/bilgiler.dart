import 'package:flutterproject/dbhelper.dart';
import 'package:flutter/cupertino.dart';

class Bilgiler {
  int id;
  String ad;
  String soyad;
  String rutbe;
  int sicil;

  Bilgiler(this.id,this.ad, this.soyad, this.rutbe, this.sicil);

  Bilgiler.fromMap(Map<String, dynamic> map)
      : id= map['id'] ?? 0,
        ad = map['ad'] ?? '',
        soyad = map['soyad'] ?? '',   // Non-nullable instance field 'rutbe' must be initialized.HATASI VERİYORDU ?? VE "" KULLANARAK ÇÖZDÜK.
        rutbe = map['rutbe'] ?? '',
        sicil = map['sicil'] ?? 0;
}
Map<String,dynamic> toMap () {
  var id;
  var ad;
  var soyad;
  var rutbe;
  var sicil;
  return {
    DatabaseHelper.columnid: id,
    DatabaseHelper.columnad: ad,
    DatabaseHelper.columnsoyad: soyad,
    DatabaseHelper.columnrutbe: rutbe,
    DatabaseHelper.columnsicil: sicil,
  };
}
