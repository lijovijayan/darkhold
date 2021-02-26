import 'package:darkhold/models/models.dart';
import 'package:darkhold/services/sqlite.services/task.table.service.dart';

enum TaskList {
  byTime,
  byCategory,
}

class PTask {
  List<MTask> _tasks;
  get tasks => this._tasks;

  addTask(
    int categoryId,
    String name,
    String date,
    String time,
  ) {}

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

  void fetchTasksByCategory(int categoryId) async {
    try {
      final List<MTask> tasks =
          await TaskTableService.getTasksByCategoryId(categoryId);
      this._tasks = tasks;
    } catch (err) {
      this._tasks = [];
    }
  }
}
