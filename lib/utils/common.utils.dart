import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

String getRandomColor() {
  var random = new Random();
  String letters = '0123456789ABCDEF';
  String color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[(random.nextInt(16 - 1)).floor()];
  }
  return color;
}

String getFormatedDateString(DateTime date) {
  final day = _getFormatedValue(date.day);
  final month = _getFormatedValue(date.month);
  return '$day-$month-${date.year}';
}

String getFormatedTimeString(TimeOfDay time) {
  final period = time.period == DayPeriod.pm ? 'PM' : 'AM';
  final _hour = time.period == DayPeriod.pm ? time.hour - 12 : time.hour;
  final hour = _getFormatedValue(_hour);
  final minute = _getFormatedValue(time.minute);
  return '$hour:$minute $period';
}

DateTime getDateFromString(String d) {
  final values = d.split('-');
  return new DateTime(
      int.parse(values[2]), int.parse(values[1]), int.parse(values[0]));
}

TimeOfDay getTimeFromString(String t) {
  final value1 = t.split(":");
  final value2 = value1[1].split(' ');
  final _hour = value1[0];
  final minuite = value2[0];
  final period = value2[1];
  final hour = period == 'AM' ? _hour : (int.parse(_hour) + 12);
  return new TimeOfDay(hour: hour, minute: int.parse(minuite));
}

String _getFormatedValue(int value) {
  return value < 10 ? '0$value' : '$value';
}
