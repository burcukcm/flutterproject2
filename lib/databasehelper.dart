import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'infos.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS infos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        port INTEGER,
        branch TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertData(String title,int port, String branchName, String date) async {
    final db = await database;
    var branch;
    await db.insert('infos', {
      'title': title,
      'port': port,
      'branch': branch,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;
    return await db.query('infos');
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('infos', where: 'id = ?', whereArgs: [id]);
  }

// CRUD işlemleri burada eklenebilir: güncelleme, sorgulama vb.
}