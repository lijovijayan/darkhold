import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';
import '../../sqlite.config.dart';

class TaskTable {
  static insert(MTask task) async {
    final Database db = await SQLiteConfig.database;
    try {
      TTask _task = TTask(
        id: null,
        name: task.name,
        date: task.date,
        time: task.time,
        completed: 0,
        categoreyId: task.categoreyId,
      );
      await db.insert(
        TASK,
        _task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<TTask>> getAllTasks() async {
    final Database db = await SQLiteConfig.database;
    try {
      final List<Map<String, dynamic>> results = await db.query(TASK);
      return List.generate(results.length, (i) {
        return TTask(
            id: results[i]['id'],
            name: results[i]['name'],
            date: results[i]['date'],
            time: results[i]['time'],
            categoreyId: results[i]['categoreyId'],
            completed: results[i]['completed']);
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<MTask>> getTasksByCategoreyId(int categoreyId) async {
    final Database db = await SQLiteConfig.database;
    final String sql = '''SELECT 
                          TASK.id,
                          TASK.categoreyId,
                          CATEGOREY.name as categoreyName,
                          TASK.name,
                          TASK.date,
                          TASK.time,
                          TASK.completed,
                          CATEGOREY.color as color
                          FROM TASK 
                          INNER JOIN CATEGOREY ON 
                          TASK.categoreyId = CATEGOREY.id
                          WHERE TASK.categoreyId = $categoreyId''';
    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return MTask(
            id: results[i]['id'],
            name: results[i]['name'],
            date: results[i]['date'],
            time: results[i]['time'],
            categoreyId: results[i]['categoreyId'],
            categoreyName: results[i]['categoreyName'],
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
            categoreyId: results[i]['categoreyId'],
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
