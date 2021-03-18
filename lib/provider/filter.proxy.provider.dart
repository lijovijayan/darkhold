import 'package:darkhold/models/models.dart';
import 'filter.provider.dart';

class PTaskFilter {
  final List<MTask> _tasks;
  final TaskFilter _filter;
  final dynamic _filterValue;
  PTaskFilter(this._tasks, this._filter, this._filterValue)
      : assert(_tasks != null && _filter != null && _filterValue != null);
  get tasks => _getFilteredList();

  List<MTask> _getFilteredList() {
    switch (this._filter) {
      case TaskFilter.date:
        return _getTasksByDate(this._filterValue);
      case TaskFilter.category:
        return _getTasksByCategory(this._filterValue);
      case TaskFilter.completed:
        return _getCompletedTasks();
      case TaskFilter.pending:
        return _getPendingTasks();
      default:
        return this._tasks;
    }
  }

  List<MTask> _getTasksByDate(DateTime date) {
    return this._tasks.where((t) =>
        t.date.day == date.day &&
        t.date.month == date.month &&
        t.date.year == date.year);
  }

  List<MTask> _getTasksByCategory(int categoryId) {
    return this._tasks.where((t) => t.categoryId == categoryId);
  }

  List<MTask> _getCompletedTasks() {
    return this._tasks.where((t) => t.completed);
  }

  List<MTask> _getPendingTasks() {
    return this._tasks.where((t) => !t.completed);
  }
}
