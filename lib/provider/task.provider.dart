import 'package:flutter/foundation.dart';

import '../models/models.dart';
import '../services/sqlite.services/task.table.service.dart';

enum TaskList {
  byTime,
  byCategory,
}

class PTask extends ChangeNotifier {
  PTask() {
    fetchAllTasks();
  }
  List<MTask> _tasks = [];
  List<MTask> get tasks => this._tasks;

  addTask({MCategory category, String name, String date, String time}) async {
    MTask task = await TaskTableService.insert(
      category: category,
      name: name,
      date: date,
      time: time,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void fetchTaskList(TaskList type, dynamic data) {
    switch (type) {
      case TaskList.byTime:
        fetchTasksByTime(data);
        break;
      case TaskList.byCategory:
        fetchTasksByCategory(data);
        break;
      default:
        this._tasks = [];
    }
  }

  void fetchTasksByTime(DateTime date) {
    // TaskTableService.getTasksByCategoryId();
  }

  void fetchAllTasks() async {
    try {
      final List<MTask> tasks = await TaskTableService.getAllTasks();
      this._tasks = tasks;
      notifyListeners();
    } catch (err) {
      this._tasks = [];
      notifyListeners();
    }
  }

  void fetchTasksByCategory(int categoryId) async {
    try {
      final List<MTask> tasks =
          await TaskTableService.getTasksByCategoryId(categoryId);
      this._tasks = tasks;
      notifyListeners();
    } catch (err) {
      this._tasks = [];
      notifyListeners();
    }
  }

  void updateTask(MTask task) async {
    try {
      final MTask _task = await TaskTableService.update(task);
      this._tasks = this._tasks.map((t) {
        if (t.id == _task.id) {
          return _task;
        }
        return t;
      }).toList();
      notifyListeners();
    } catch (err) {
      notifyListeners();
    }
  }
}
