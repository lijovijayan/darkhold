import 'package:darkhold/models/models.dart';
import 'package:sqflite/sqflite.dart';
import '../sqlite.config.dart';

class CategoreyTable {
  static insert(Categorey categorey) async {
    final Database db = await SQLiteConfig.database;
    try {
      TCategorey _categorey =
          TCategorey(id: null, color: categorey.color, name: categorey.name);
      await db.insert(
        CATEGOREY,
        _categorey.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<Categorey>> getAllCategories() async {
    final Database db = await SQLiteConfig.database;
    const String sql = '''SELECT
                        CATEGOREY.id,
                        CATEGOREY.name,
                        CATEGOREY.color,
	                      SUM(CASE WHEN TASK.categoreyId = CATEGOREY.id 
                          THEN 1 ELSE 0 END) as totalTasks,
    	                  SUM(CASE WHEN TASK.completed = 1 AND TASK.categoreyId = CATEGOREY.id 
                          THEN 1 ELSE 0 END) as completedTasks
                        FROM CATEGOREY
                        LEFT JOIN TASK
                        GROUP BY CATEGOREY.id''';
    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return Categorey(
          id: results[i]['id'],
          name: results[i]['name'],
          color: results[i]['color'],
          totalTasks: results[i]['totalTasks'],
          completedTasks: results[i]['completedTasks'],
        );
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static delete(int id) async {
    try {
      final Database db = await SQLiteConfig.database;
      return await db.rawQuery('DELETE FROM $CATEGOREY WHERE id=$id');
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<Categorey>> getCategoreyById(int id) async {
    try {
      final Database db = await SQLiteConfig.database;
      final sql = '''SELECT CATEGOREY.id,
                    CATEGOREY.name,
                    CATEGOREY.color,
                    SUM(CASE WHEN TASK.categoreyId = CATEGOREY.id 
                      THEN 1 ELSE 0 END) as totalTasks,
                    SUM(CASE WHEN TASK.completed = 1 AND TASK.categoreyId = CATEGOREY.id 
                      THEN 1 ELSE 0 END) as completedTasks
                    FROM CATEGOREY LEFT JOIN TASK 
                    WHERE CATEGOREY.id = $id''';
      final List<Map<String, dynamic>> results =
          await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return Categorey(
          id: results[i]['id'],
          name: results[i]['name'],
          color: results[i]['color'],
          totalTasks: results[i]['totalTasks'],
          completedTasks: results[i]['completedTasks'],
        );
      });
    } catch (err) {
      print(err);
      return null;
    }
  }

  static drop() async {
    final Database db = await SQLiteConfig.database;
    try {
      return await db.rawQuery('DROP TABLE IF EXISTS $CATEGOREY');
    } catch (err) {
      print(err);
      return null;
    }
  }
}

class TaskTable {
  static insert(Task task) async {
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

  static Future<List<Task>> getTasksByCategoreyId(int categoreyId) async {
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
        return Task(
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
