import '../models/models.dart';
import 'filter.provider.dart';

class TaskProvider {
  final List<MTask> _tasks;
  final TaskFilter _filter;
  final dynamic _filterValue;
  final String _searchKey;

  TaskProvider(this._tasks, this._filter, this._filterValue, this._searchKey)
      : assert(_tasks != null &&
            _filter != null &&
            _filterValue != null &&
            _searchKey != null);
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
    return this
        ._tasks
        .where((t) =>
            t.date.day == date.day &&
            t.date.month == date.month &&
            t.date.year == date.year &&
            t.name.toLowerCase().startsWith(_searchKey.toLowerCase()))
        .toList();
  }

  List<MTask> _getTasksByCategory(MCategory category) {
    return this
        ._tasks
        .where((t) =>
            t.categoryId == category.id &&
            t.name.toLowerCase().startsWith(_searchKey.toLowerCase()))
        .toList();
  }

  List<MTask> _getCompletedTasks() {
    return this
        ._tasks
        .where((t) =>
            t.completed &&
            t.name.toLowerCase().startsWith(_searchKey.toLowerCase()))
        .toList();
  }

  List<MTask> _getPendingTasks() {
    return this
        ._tasks
        .where((t) =>
            !t.completed &&
            t.name.toLowerCase().startsWith(_searchKey.toLowerCase()))
        .toList();
  }
}
