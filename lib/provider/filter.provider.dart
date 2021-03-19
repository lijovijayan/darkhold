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
  dynamic _filterValue = DateTime.now();
  TaskFilter get filter => this._filter;
  dynamic get filterValue => this._filterValue;

  // value must be either DateTime or int
  void changeFilter(TaskFilter __filter, {dynamic value = true}) async {
    assert((value != null && (value == DateTime || value == int)),
        'value must be either DateTime or int');
    this._filter = __filter;
    this._filterValue = value;
    notifyListeners();
  }
}
