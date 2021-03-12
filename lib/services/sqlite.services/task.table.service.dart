import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';
import '../../sqlite.config.dart';

class TaskTableService {
  static Future<MTask> insert(
      {MCategory category, String name, String date, String time}) async {
    final Database db = await SQLiteConfig.database;
    try {
      TTask _task = TTask(
        id: null,
        name: name,
        date: date,
        time: time,
        completed: 0,
        categoryId: category.id,
      );
      final id = await db.insert(
        TASK,
        _task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return MTask(
          id: id,
          categoryId: category.id,
          categoryName: category.name,
          name: _task.name,
          date: _task.date,
          time: _task.time,
          completed: false,
          color: category.color);
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<MTask>> getAllTasks() async {
    final Database db = await SQLiteConfig.database;
    final String sql = '''SELECT 
                          TASK.id,
                          TASK.categoryId,
                          CATEGORY.name as categoryName,
                          TASK.name,
                          TASK.date,
                          TASK.time,
                          TASK.completed,
                          CATEGORY.color as color
                          FROM TASK 
                          INNER JOIN CATEGORY ON 
                          TASK.categoryId = CATEGORY.id''';
    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return MTask(
            id: results[i]['id'],
            name: results[i]['name'],
            date: results[i]['date'],
            time: results[i]['time'],
            categoryId: results[i]['categoryId'],
            categoryName: results[i]['categoryName'],
            completed: results[i]['completed'] == 1 ? true : false,
            color: results[i]['color']);
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<MTask>> getTasksByCategoryId(int categoryId) async {
    final Database db = await SQLiteConfig.database;
    final String sql = '''SELECT 
                          TASK.id,
                          TASK.categoryId,
                          CATEGORY.name as categoryName,
                          TASK.name,
                          TASK.date,
                          TASK.time,
                          TASK.completed,
                          CATEGORY.color as color
                          FROM TASK 
                          INNER JOIN CATEGORY ON 
                          TASK.categoryId = CATEGORY.id
                          WHERE TASK.categoryId = $categoryId''';
    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return MTask(
            id: results[i]['id'],
            name: results[i]['name'],
            date: results[i]['date'],
            time: results[i]['time'],
            categoryId: results[i]['categoryId'],
            categoryName: results[i]['categoryName'],
            completed: results[i]['completed'] == 1 ? true : false,
            color: results[i]['color']);
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<TTask>> getTaskId(int id) async {
    final Database db = await SQLiteConfig.database;
    try {
      final List<Map<String, dynamic>> results =
          await db.rawQuery('SELECT * FROM "$TASK" WHERE id=$id');
      return List.generate(results.length, (i) {
        return TTask(
            id: results[i]['id'],
            name: results[i]['name'],
            date: results[i]['date'],
            time: results[i]['time'],
            categoryId: results[i]['categoryId'],
            completed: results[i]['completed']);
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static delete(int id) async {
    try {
      final Database db = await SQLiteConfig.database;
      return await db.rawQuery('DELETE FROM $TASK WHERE id=$id');
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<MTask> update(MTask task) async {
    final Database db = await SQLiteConfig.database;
    try {
      TTask _task = TTask(
        id: task.id,
        name: task.name,
        date: task.date,
        time: task.time,
        completed: task.completed ? 1 : 0,
        categoryId: task.categoryId,
      );
      await db.update(
        TASK,
        _task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return task;
    } catch (err) {
      print(err);
      return null;
    }
  }

  static drop() async {
    final Database db = await SQLiteConfig.database;
    try {
      return await db.rawQuery('DROP TABLE IF EXISTS $TASK');
    } catch (err) {
      print(err);
      return null;
    }
  }
}
