import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static bool isSameDay(DateTime dateTimeSource, DateTime dateTimeDestination) {
    return dateTimeSource.year == dateTimeDestination.year &&
        dateTimeSource.month == dateTimeDestination.month &&
        dateTimeSource.day == dateTimeDestination.day;
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
    try {
      final dateTimeSource = DateTime.parse(dateTimeSourceString);
      final dateTimeDestination = DateTime.parse(dateTimeDestinationString);

      return isSameDay(dateTimeSource, dateTimeDestination);
    } catch (e) {
      throw Exception('Day is not valid');
    }
  }

  static bool isTodayString(String dateTimeString) {
    if (dateTimeString == null) return false;
    return isSameDayString(dateTimeString, DateTime.now().toIso8601String());
  }

  static bool isTomorrowString(String dateTimeString) {
    return isTomorrow(DateTime.parse(dateTimeString));
  }

  static bool isOverdue(DateTime dateTimeSource, DateTime dateTimeDestination) {
    return dateTimeSource.compareTo(DateTime(
          dateTimeDestination.year,
          dateTimeDestination.month,
          dateTimeDestination.day,
        )) <
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

  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime dateOnlyWithStringDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime getDefaultTimeReminder(DateTime date) {
    return DateTime(date.year, date.month, date.day, 9);
  }

  static DateTime getDateWithTime(DateTime date, TimeOfDay timeOfDay) {
    return DateTime(
        date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);
  }

  static TimeOfDay getTimeOfDayFromDateString(String date) {
    if (date == null) return null;

    final dateTime = DateTime.parse(date);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
