import 'dart:async';
import 'package:flutterproject/bilgiler.dart';
import 'package:flutterproject/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';  //join fonksiyonunu kullanmak için

class DatabaseHelper {
  static const _databasename = "bilgiler.db";
  static const _databaseVersion = 1;
  static const table = 'bilgiler_table';
  static const columnid = 'id';
  static const columnad = 'ad';
  static const columnsoyad = 'soyad';
  static const columnrutbe = 'rutbe';
  static const columnsicil = 'sicil';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return database;
    _database = await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databasename);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE  $table(
    $columnid İNTEGER PRİMARY KEY AUTOINCREMENT,
    $columnad TEXT  NOT NULL,
    $columnrutbe TEXT NOT NULL,
    $columnsicil TEXT NOT NULL,
    $columnsoyad TEXT NOT NULL
    )
    ''');
  }

  Future<int> insert(Bilgiler bilgiler) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'ad': bilgiler.ad,
      'soyad': bilgiler.soyad,
      'rutbe': bilgiler.rutbe,
      'sicil': bilgiler.sicil,
    });
  }

  Future<int> update(Bilgiler bilgiler) async {
    Database? db = await instance.database;
    int id = toMap()['id'];
    return await db!.update(
        table, Bilgiler.toMap(), where: '$columnid =?', whereArgs: [id]);
  }

  Future<int> delete(int sicil) async {
    Database? db = await instance.database;
    int id = toMap()['id'];
    return await db!.delete(
        table, Bilgiler.toMap(), where: '$columnid =?', whereArgs: [id]);
  }
}