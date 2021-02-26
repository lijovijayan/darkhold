import 'package:flutter/foundation.dart';

class MCategory {
  final int id;
  final String name;
  final int totalTasks;
  final int completedTasks;
  final String color;
  MCategory({
    @required this.id,
    @required this.name,
    @required this.totalTasks,
    @required this.completedTasks,
    @required this.color,
  });
}
