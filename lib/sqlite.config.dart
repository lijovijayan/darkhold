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
      date TEXT,
      time TEXT,
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
