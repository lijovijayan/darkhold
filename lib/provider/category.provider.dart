import '../models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PCategory with ChangeNotifier {
  List<MCategory> _categories = [];

  List<MCategory> get categories => this._categories;

  void addCategory(MCategory category) {
    this._categories.add(category);
    notifyListeners();
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
}
