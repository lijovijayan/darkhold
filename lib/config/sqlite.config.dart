import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String CATEGORY = 'CATEGORY';
const String TASK = 'TASK';

class SQLiteConfig {
  static Future<Database> _database;
  static const String _category_table_create = '''
    CREATE TABLE IF NOT EXISTS $CATEGORY(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT UNIQUE,
      color TEXT
    )''';
  static const String _task_table_create = '''
    CREATE TABLE IF NOT EXISTS $TASK(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      categoryId INTEGER NOT NULL,
      name TEXT UNIQUE,
      completed INTEGER,
      date TEXT,
      time TEXT,
      FOREIGN KEY(categoryId) REFERENCES CATEGORY(id)
      ON DELETE CASCADE
    )''';
  static void syncDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    _database = openDatabase(
        join(await getDatabasesPath(), 'darkhold_database.db'),
        version: 1,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  static get database async {
    if (_database != null) {
      return _database;
    } else {
      return openDatabase(
          join(await getDatabasesPath(), 'darkhold_database.db'),
          version: 1,
          onCreate: _onCreate,
          onConfigure: _onConfigure);
    }
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(_category_table_create);
    await db.execute(_task_table_create);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
