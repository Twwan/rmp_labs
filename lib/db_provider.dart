import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = '${directory.path}lab.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""CREATE TABLE Lab(
                              id INTEGER PRIMARY KEY AUTOINCREMENT,
                              fileType TEXT,
                              channels TEXT,
                              samplingRate TEXT,
                              bitDepth TEXT,
                              duration TEXT,
                              fileSize REAL
                          )""");
  }

  Future<void> addValues(Map<String, dynamic> values) async {
    Database db = await database;
    await db.insert('Lab', values);
  }

  Future<List<Map<String, dynamic>>> getAllValues() async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('Lab');
    return data;
  }

  Future<Map<String, dynamic>?> getValues(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('Lab', where: 'id = ?', whereArgs: [id]);
    return data.isNotEmpty ? data.first : null;
  }
}
