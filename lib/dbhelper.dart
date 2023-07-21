import 'dart:async';
import 'package:flutterproject/Infos.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databasename = "infos.db";
  static const _databaseVersion = 1;
  static const table = 'infos_table';
  static const columnid = 'id';
  static const columnname= 'name';
  static const columnsurname= 'surname';
  static const columnrank = 'rank';
  static const columnrecord = 'record';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databasename);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE  $table(
    $columnid INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnname TEXT NOT NULL,
    $columnrank TEXT NOT NULL,
    $columnrecord TEXT NOT NULL,
    $columnsurname TEXT NOT NULL
    )
    ''');
  }
  Future<int> insert(Infos infos) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'name': infos.name,
      'surname': infos.surname,
      'rank': infos.rank,
      'record': infos.record,
    });
  }
  Future<int> update(Infos infos) async {
    Database? db = await instance.database;
    int id = Infos.toMap()[columnid];
    return await db!.update(
      table,
      Infos.toMap(),
      where: '$columnid = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(
      table,
      where: '$columnid = ?',
      whereArgs: [id],
    );
  }

  Future<List<Infos>> queryAll() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> maps = await db!.query(table);
    return List.generate(maps.length, (index) {
      return Infos(
        id: maps[index][columnid],
        name: maps[index][columnname],
        surname: maps[index][columnsurname],
        rank: maps[index][columnrank],
        record: maps[index][columnrecord],
      );
    });
  }
}
