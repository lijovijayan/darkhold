import 'package:flutter/foundation.dart';

class TCategory {
  final int id;
  final String name;
  final String color;
  TCategory({
    @required this.id,
    @required this.name,
    @required this.color,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

class TTask {
  final int id;
  final int categoryId;
  final String name;
  final String date;
  final String time;
  final int completed;
  TTask({
    @required this.id,
    @required this.categoryId,
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.completed,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'date': date,
      'time': time,
      'completed': completed,
    };
  }
}
