import 'package:flutterproject/dbhelper.dart';
class Infos {
  int? id;
  String name;
  String surname;
  String rank;
  int record;

  Infos({
    this.id,
    required this.name,
    required this.surname,   //kullanabilmek için constructor içine almamız gerekiyor.
    required this.rank,
    required this.record,
  });
 Infos.fromMap(Map<String, dynamic> map)
      : id= map['id'] ,
        name = map['name'] ,
        surname= map['surname'] ,
        rank= map['rank'],
        record = map['record'] ;
  static toMap() {}
}
Map<String,dynamic> toMap () {
  var id;
  var name;
  var surname;
  var rank;
  var record;
  return {
    DatabaseHelper.columnid: id,
    DatabaseHelper.columnname: name,
    DatabaseHelper.columnsurname: surname,
    DatabaseHelper.columnrank: rank,
    DatabaseHelper.columnrecord: record,
  };
}
