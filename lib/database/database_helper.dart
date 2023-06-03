import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/moviemodel.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._private();
  static final String tableName = 'favorites';

  static Database? _database;

  DatabaseHelper._private();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'favoritesmodel.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            year TEXT
          )
        ''');
      },
    );
  }

  Future<int> insert(MovieModel movie) async {
    final db = await instance.database;
    return await db.insert(tableName, movie.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query(tableName);
  }
}
