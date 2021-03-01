import 'package:flutter/material.dart';
import '../services/services.dart';
import '../models/models.dart';

class PCategory with ChangeNotifier {
  PCategory() {
    fetchAllCategories();
  }

  List<MCategory> _categories = [];

  List<MCategory> get categories => this._categories;

  void addCategory(name) async {
    const String color = '#FFFFFF';
    final MCategory category =
        await CategoryTableService.insert(name: name, color: color);
    if (category != null) {
      this._categories.add(category);
      notifyListeners();
    } else {
      print('Error: Someting went wrong while adding new Category');
    }
  }

  void removeCategory(MCategory category) {
    if (this.categories.remove(category)) {
      notifyListeners();
    }
  }

  void updateCategory(MCategory category) {
    final index =
        this.categories.indexWhere((_category) => _category.id == category.id);
    if (index != -1) {
      this.categories[index] = category;
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
