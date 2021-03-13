import 'package:darkhold/utils/common.utils.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import '../models/models.dart';

class PCategory with ChangeNotifier {
  PCategory() {
    fetchAllCategories();
    print('constructor');
  }

  List<MCategory> _categories = [];

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

  void removeCategory(MCategory category) {
    if (this.categories.remove(category)) {
      notifyListeners();
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

  void fetchAllCategories() async {
    List<MCategory> categories = await CategoryTableService.getAllCategories();
    if (categories != null) {
      this._categories = categories;
      notifyListeners();
    }
  }
}
