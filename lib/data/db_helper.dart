import 'package:flutter_app/utils/secure_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

//기기 안에 db 생성해서 데이터 저장하기
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); // 앱 내부 DB 저장 경로
    final path = join(dbPath, filePath);

    final password = await getDbPassword();

    return await openDatabase(
      path,
      password: password,
      version: 1,
      onCreate: _createDB,
    );

  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        todoText TEXT NOT NULL,
        isDone INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  //앱 종료시 디비 닫아줄 때 사용할 메서드
  Future close() async {
    final db = await database;
    db.close();
  }

}
