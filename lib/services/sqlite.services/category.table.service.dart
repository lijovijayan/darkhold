import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';
import '../../config/sqlite.config.dart';

class CategoryTableService {
  static Future<MCategory> insert({String color, String name}) async {
    final Database db = await SQLiteConfig.database;
    try {
      TCategory _category = TCategory(id: null, color: color, name: name);
      final id = await db.insert(
        CATEGORY,
        _category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (id != null) {
        return new MCategory(
            id: id, name: name, totalTasks: 0, completedTasks: 0, color: color);
      } else {
        throw ('something went wrong while creating new category !');
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<MCategory>> getAllCategories() async {
    final Database db = await SQLiteConfig.database;
    const String sql = '''SELECT
                        CATEGORY.id,
                        CATEGORY.name,
                        CATEGORY.color,
	                      SUM(CASE WHEN TASK.categoryId = CATEGORY.id 
                          THEN 1 ELSE 0 END) as totalTasks,
    	                  SUM(CASE WHEN TASK.completed = 1 AND TASK.categoryId = CATEGORY.id 
                          THEN 1 ELSE 0 END) as completedTasks
                        FROM CATEGORY
                        LEFT JOIN TASK
                        GROUP BY CATEGORY.id''';
    try {
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return MCategory(
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

  static Future<MCategory> update({MCategory category}) async {
    final Database db = await SQLiteConfig.database;
    try {
      TCategory _category =
          TCategory(id: null, color: category.color, name: category.name);
      final id = await db.update(
        CATEGORY,
        _category.toMap(),
        where: 'id = ?',
        whereArgs: [category.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (id != null) {
        return category;
      } else {
        throw ('something went wrong');
      }
    } catch (err) {
      print(err);
      return null;
    }
  }

  static delete(int id) async {
    try {
      final Database db = await SQLiteConfig.database;
      return await db.rawQuery('DELETE FROM $CATEGORY WHERE id=$id');
    } catch (err) {
      print(err);
      return null;
    }
  }

  static Future<List<MCategory>> getCategoryById(int id) async {
    try {
      final Database db = await SQLiteConfig.database;
      final sql = '''SELECT CATEGORY.id,
                    CATEGORY.name,
                    CATEGORY.color,
                    SUM(CASE WHEN TASK.categoryId = CATEGORY.id 
                      THEN 1 ELSE 0 END) as totalTasks,
                    SUM(CASE WHEN TASK.completed = 1 AND TASK.categoryId = CATEGORY.id 
                      THEN 1 ELSE 0 END) as completedTasks
                    FROM CATEGORY LEFT JOIN TASK 
                    WHERE CATEGORY.id = $id''';
      final List<Map<String, dynamic>> results = await db.rawQuery(sql);
      return List.generate(results.length, (i) {
        return MCategory(
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
      return await db.rawQuery('DROP TABLE IF EXISTS $CATEGORY');
    } catch (err) {
      print(err);
      return null;
    }
  }
}
