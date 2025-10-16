import 'package:flutter/foundation.dart';

import '../model/todo.dart';
import '../data/db_helper.dart';

class TodoDao {
  final dbHelper = DatabaseHelper.instance;

  void _log(String message) {
    if (kDebugMode) debugPrint(message);
  }

  Future<int?> insert(Todo todo) async {
    try {
      final db = await dbHelper.database;
      final result = await db.insert('todo', todo.toMap());
      _log('Inserted todo id=$result');
      return result;
    } catch (e) {
      _log('Insert Error : $e');
      return null;
    }
  }

  Future<List<Todo>> getTodos() async {
    try {
      final db = await dbHelper.database;
      final result = await db.query('todo');
      _log('Fetched ${result.length} todos');
      return result.map((map) => Todo.fromMap(map)).toList();
    } catch (e) {
      _log('GetTodos Error : $e');
      return [];
    }
  }

  Future<int?> update(Todo todo, {bool isTextChanged = false}) async {
    try {
      final db = await dbHelper.database;
      final now = DateTime.now().toIso8601String();

      final data = {
        'todoText': todo.todoText,
        'isDone': todo.isDone ? 1 : 0,
        'updatedAt': isTextChanged ? now : todo.updatedAt, // 갱신
      };

      final count = await db.update(
        'todo',
        data,
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      _log('Updated $count rows for todo id = ${todo.id}');
      return count;
    } catch (e) {
      _log('Update Error : $e');
      return null;
    }
  }

  Future<int?> delete(int id) async {
    try {
      final db = await dbHelper.database;
      final count = await db.delete('todo', where: 'id = ?', whereArgs: [id]);
      _log('Deleted $count rows for todo id = $id');
      return count;
    } catch (e) {
      _log('Delete Error : $e');
      return null;
    }
  }

  Future<int?> deleteAll() async {
    try {
      final db = await dbHelper.database;
      final count = await db.delete('todo');
      _log('Deleted all todos, count = $count');
      return count;
    } catch (e) {
      _log('DeletedAll Error : $e');
      return null;
    }
  }

  Future<void> resetTable() async {
    try {
      final db = await dbHelper.database;
      await db.delete('todo');
      await db.delete('sqlite_sequence', where: 'name=?', whereArgs: ['todo']);
      _log('Reset todo table and autoincrement');
    } catch (e) {
      _log('ResetTable Error : $e');
    }
  }
}
