import 'package:flutter/foundation.dart';

class Task {
  final int id;
  final int categoreyId;
  final String categoreyName;
  final String name;
  final String date;
  final String time;
  final bool completed;
  final String color;
  Task({
    @required this.id,
    @required this.categoreyId,
    @required this.categoreyName,
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.completed,
    @required this.color,
  });
}
