import 'dart:async';
import 'package:flutter/foundation.dart';

enum TaskFilter {
  date,
  category,
  completed,
  pending,
}

// This provider is used to apply filter to tasklist
// PFilter never handle list of categories or tasks, it will be handled by a ProxyProvider
class FilterProvider with ChangeNotifier {
  TaskFilter _filter = TaskFilter.date;
  String _searchKey = '';
  dynamic _filterValue = DateTime.now();

  Timer timer;

  TaskFilter get filter => this._filter;
  String get searchKey => this._searchKey;
  dynamic get filterValue => this._filterValue;

  // value must be either DateTime or MCategory
  void changeFilter(TaskFilter __filter, {dynamic value = true}) async {
    if (value == this._filter) return;
    this._filter = __filter;
    this._filterValue = value;
    notifyListeners();
  }

  void search(String __searchKey) async {
    if (timer != null && timer.isActive) timer.cancel();
    timer = new Timer(const Duration(seconds: 1), () {
      this._searchKey = __searchKey;
      notifyListeners();
    });
  }
}
