import 'package:flutter/foundation.dart';

class Categorey {
  final int id;
  final String name;
  final int totalTasks;
  final int completedTasks;
  final String color;
  Categorey({
    @required this.id,
    @required this.name,
    @required this.totalTasks,
    @required this.completedTasks,
    @required this.color,
  });
}
