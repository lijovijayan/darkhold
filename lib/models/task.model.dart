import 'package:darkhold/utils/common.utils.dart';
import 'package:flutter/material.dart';

class MTask {
  final int id;
  final int categoryId;
  final String categoryName;
  final String name;
  final DateTime date;
  final TimeOfDay time;
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
  get dateToString => getFormatedDateString(this.date);
  get timeToString => getFormatedTimeString(this.time);
}
