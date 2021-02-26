import 'package:flutter/foundation.dart';

class MTask {
  final int id;
  final int categoryId;
  final String categoryName;
  final String name;
  final String date;
  final String time;
  final bool completed;
  final String color;
  MTask({
    @required this.id,
    @required this.categoryId,
    @required this.categoryName,
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.completed,
    @required this.color,
  });
}
