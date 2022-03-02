import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> getDataBase() async {
    final dbDir = await sql.getDatabasesPath();
    final dbPath = path.join(dbDir, 'places.db');
    print("Database Dir : " + dbDir + "\nDatabase Path : " + dbPath);
    return sql.openDatabase(dbPath, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY,title TEXT,image TEXT,loc_lat REAL,loc_lng REAL,address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    try {
      final db = await DBHelper.getDataBase();
      await db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      print('PLace inserted in database' + data.toString());
    } catch (e) {
      print("EXCEPTION : " + e.toString());
    }
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await DBHelper.getDataBase();
    return db.query(table);
  }
}
