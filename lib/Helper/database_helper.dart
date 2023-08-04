import 'package:flutterproject/Models/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //Singleton Tasarım
  static final DatabaseHelper _instance = DatabaseHelper
      ._internal(); //Databasehelper sınıfının bir örneği oluşturulur ve _instance değişkenine atanır.Değişken yalnızca 1 örneğe referans olur.
  factory DatabaseHelper() =>
      _instance; //factory= nesne oluşturmak yerine zaten varolan bir nesneyi döndüren özel bir kurucu yöntem oluşturur.factory her çağırıldığında _instance değ. döndürür.
  DatabaseHelper._internal(); //  Databasehelper sınıfının özel kurucu yöntemidir.Sadece bu snıf içinden çağrılabilir.

  static Database? _database; // Başlangıçta _databasse değeri nulldır.

  Future<Database> get database async {
    //database adında bir asenkron getter yöntemidir. Asenkron işlemler, beklemeyi gerektiren işlemleri etkin bir şekilde yönetmek için kullanılır.
    if (_database != null) {
      return _database!; //Bu satır, _database değişkeninin null olup olmadığını kontrol eder. Null değilse var olanı döndürür.
    }
    _database =
        await initDatabase(); //Eğer _database null ise, initDatabase() adında başka bir asenkron yöntemi çağırır. Bu yöntem veritabanını oluşturur ve hazır hale getirir.
    return _database!; //initDatabase() asenkron olduğu için await kullanılmış.Son olarak, oluşturulan veritabanı örneği döndürülür.
  }

  Future<Database> initDatabase() async {
    //bu fonksiyon, uygulamada SQLite veritabanı kullanmak için gerekli olan bağlantıyı açar ve oluşturur.
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

  Future<void> addData(DataModel dataModel) async {
    if (dataModel.title.isEmpty ||
        dataModel.branchName.isEmpty ||
        dataModel.date.isEmpty) {
      throw Exception('Please fill in all fields.');
    }
    final db = await database;
    await db.insert('infos', dataModel.toMap());
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;
    return await db.query('infos');
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('infos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateData(Map<String, dynamic> newData) async {
    final db = await database;
    int id = newData['id'];
    await db.update(
      'infos',
      newData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
