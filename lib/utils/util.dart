import 'dart:ui';

import 'package:intl/intl.dart';

class Util {
  static String getHexFromColor(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}';
  }

  static bool isSameDay(DateTime dateTimeSource, DateTime dateTimeDestination) {
    return dateTimeSource.compareTo(
          DateTime(
            dateTimeDestination.year,
            dateTimeDestination.month,
            dateTimeDestination.day,
          ),
        ) ==
        0;
  }

  static String getDisplayTextDateFromDate(String dateTime) {
    if (dateTime != null && dateTime.isNotEmpty) {
      final date = DateTime.parse(dateTime);
      if (isSameDay(date, DateTime.now())) {
        return "To Day";
      } else {
        return DateFormat("dd/MM/yyyy").format(date);
      }
    }
    return null;
  }
}
