import 'package:darkhold/utils/common.utils.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../models/models.dart';

class CoreProvider with ChangeNotifier {
  List<MCategory> _categories = [];
  List<MTask> _tasks = [];
  CoreProvider() {
    fetchAllCategories();
    fetchTasks();
  }

  List<MTask> get tasks => this._tasks;
  List<MCategory> get categories => this._categories;

  Future<MCategory> addCategory(String name) async {
    String color = getRandomColor();
    final MCategory category =
        await CategoryTableService.insert(name: name, color: color);
    if (category != null) {
      this._categories.add(category);
      notifyListeners();
      return category;
    } else {
      print('Error: Someting went wrong while adding new Category');
      return null;
    }
  }

  void updateCategory(MCategory category) {
    final index =
        this._categories.indexWhere((_category) => _category.id == category.id);
    if (index != -1) {
      this._categories[index] = category;
      notifyListeners();
    }
  }

  void updateCompletedTaskCountById(int categoryId, bool completed) {
    final index =
        this._categories.indexWhere((_category) => _category.id == categoryId);
    if (index != -1) {
      final MCategory category = this._categories[index];
      this._categories[index] = MCategory(
          id: category.id,
          name: category.name,
          totalTasks: category.totalTasks,
          completedTasks: completed
              ? category.completedTasks + 1
              : category.completedTasks - 1,
          color: category.color);
      notifyListeners();
    }
  }

  void updateTableCategory(MCategory category) {
    final index =
        this._categories.indexWhere((_category) => _category.id == category.id);
    if (index != -1) {
      this._categories[index] = category;
      notifyListeners();
    }
  }

  void removeCategory(MCategory category) {
    if (this.categories.remove(category)) {
      notifyListeners();
    }
  }

  void fetchAllCategories() async {
    List<MCategory> categories = await CategoryTableService.getAllCategories();
    if (categories != null) {
      this._categories = categories;
      notifyListeners();
    }
  }
  // END - CATEGORY data modification functions

  // TASK data modification functions
  addTask({MCategory category, String name, String date, String time}) async {
    MTask task = await TaskTableService.insert(
      category: category,
      name: name,
      date: date,
      time: time,
    );
    if (task != null) {
      _tasks.add(task);
      final index = this._categories.indexWhere((t) => t.id == task.categoryId);
      this._categories[index] = MCategory(
          id: category.id,
          name: category.name,
          totalTasks: category.totalTasks + 1,
          completedTasks: category.completedTasks,
          color: category.color);
      notifyListeners();
    }
  }

  void updateTask(MTask task) async {
    try {
      final index = this._tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        this._tasks[index] = task;
        updateCompletedTaskCountById(task.categoryId, task.completed);
      }
    } catch (err) {
      notifyListeners();
    }
  }

  void updateTableTask(MTask task) async {
    try {
      final index = this._tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        final MTask _task = await TaskTableService.update(task);
        if (_task != null) {
          updateTask(_task);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  void fetchTasks() async {
    try {
      final List<MTask> tasks = await TaskTableService.getAllTasks();
      if (tasks != null) {
        this._tasks = tasks;
        notifyListeners();
      }
    } catch (err) {
      this._tasks = [];
      notifyListeners();
    }
  }
  // END - TASK data modification functions
}
