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

  static bool isTomorrow(DateTime dateTimeSource) {
    return isAfterNumberDay(dateTimeSource, 1);
  }

  static bool isAfterNumberDay(DateTime dateTime, int numberOfDay) {
    return dateTime
            .difference(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
            )
            .inDays ==
        numberOfDay;
  }

  static bool isSameDayString(
      String dateTimeSourceString, String dateTimeDestinationString) {
    final dateTimeSource = DateTime.parse(dateTimeSourceString);
    final dateTimeDestination = DateTime.parse(dateTimeDestinationString);

    return isSameDay(dateTimeSource, dateTimeDestination);
  }

  static bool isTodayString(String dateTimeString) {
    return isSameDayString(dateTimeString, DateTime.now().toIso8601String());
  }

  static bool isTomorrowString(String dateTimeString) {
    return isTomorrow(DateTime.parse(dateTimeString));
  }

  static bool isOverdue(DateTime dateTimeSource, DateTime dateTimeDestination) {
    return dateTimeSource.compareTo(
          DateTime(
            dateTimeDestination.year,
            dateTimeDestination.month,
            dateTimeDestination.day,
          ),
        ) <
        0;
  }

  static bool isOverDueString(String dateTimeSourceString) {
    final dateTimeSource = DateTime.parse(dateTimeSourceString);

    return isOverdue(dateTimeSource, DateTime.now());
  }

  static String getNameOfDay(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static String getDisplayTextDateFromDate(String dateTime) {
    if (dateTime != null && dateTime.isNotEmpty) {
      final date = DateTime.parse(dateTime);
      if (isSameDay(date, DateTime.now())) {
        return "To Day";
      }
      // else if (isOverdue(date, DateTime.now())) {
      //   return "Overdue";
      // }
      else {
        return DateFormat("dd/MM/yyyy").format(date);
      }
    }
    return null;
  }
}
