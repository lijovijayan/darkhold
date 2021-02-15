import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/models.dart';

const String CATEGOREY = 'CATEGOREY';
const String TASK = 'TASK';

class SQLiteConfig {
  static Future<Database> database;
  static const String _categorey_table_create = '''
    CREATE TABLE IF NOT EXISTS $CATEGOREY(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      color TEXT
    )''';
  static const String _task_table_create = '''
    CREATE TABLE IF NOT EXISTS $TASK(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      categoreyId INTEGER NOT NULL,
      name TEXT,
      completed INTEGER,
      FOREIGN KEY(categoreyId) REFERENCES CATEGOREY(id)
      ON DELETE CASCADE
    )''';
  static void syncDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
        join(await getDatabasesPath(), 'darkhold_database.db'),
        version: 1,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(_categorey_table_create);
    await db.execute(_task_table_create);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}

class CategoreyTable {
  static insert(Categorey categorey) async {
    final Database db = await SQLiteConfig.database;
    TCategorey _categorey =
        TCategorey(id: null, color: categorey.color, name: categorey.name);
    await db.insert(
      CATEGOREY,
      _categorey.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TCategorey>> getAllCategories() async {
    final Database db = await SQLiteConfig.database;
    final List<Map<String, dynamic>> results = await db.query(CATEGOREY);
    return List.generate(results.length, (i) {
      return TCategorey(
          id: results[i]['id'],
          name: results[i]['name'],
          color: results[i]['color'],
          );
    });
  }

  static delete(int id) async {
    final Database db = await SQLiteConfig.database;
    final result = await db.rawQuery('DELETE FROM $CATEGOREY WHERE id=$id');
    print(result);
  }

  static drop() async {
    final Database db = await SQLiteConfig.database;
    await db.rawQuery('DROP TABLE IF EXISTS $CATEGOREY');
  }
}

class TaskTable {
  static insert(Task task) async {
    final Database db = await SQLiteConfig.database;
    TTask _task = TTask(
        id: null, name: task.name, completed: 0, categoreyId: task.categoreyId);
    await db.insert(
      TASK,
      _task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<TTask>> getAllTasks() async {
    final Database db = await SQLiteConfig.database;
    final List<Map<String, dynamic>> results = await db.query(TASK);
    return List.generate(results.length, (i) {
      return TTask(
          id: results[i]['id'],
          name: results[i]['name'],
          categoreyId: results[i]['categoreyId'],
          completed: results[i]['completed']);
    });
  }

  static Future<List<TTask>> getTasksByCategoreyId(int categoreyId) async {
    final Database db = await SQLiteConfig.database;
    final List<Map<String, dynamic>> results = await db
        .rawQuery('SELECT * FROM "$TASK" WHERE categoreyId=$categoreyId');
    return List.generate(results.length, (i) {
      return TTask(
          id: results[i]['id'],
          name: results[i]['name'],
          categoreyId: results[i]['categoreyId'],
          completed: results[i]['completed']);
    });
  }

  static drop() async {
    final Database db = await SQLiteConfig.database;
    final result = await db.rawQuery('DROP TABLE IF EXISTS $TASK');
    print(result);
  }
}
