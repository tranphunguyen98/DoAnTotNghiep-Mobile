import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totodo/utils/util.dart';

class DateHelper {
  static String getStringAddedDurationDate(String date, Duration duration) {
    return DateTime.parse(date).add(duration).toIso8601String();
  }

  static List<String> getListDayOfMonth(int subtractMonth) {
    final date = DateUtils.addMonthsToMonthDate(DateTime.now(), -subtractMonth);
    log('testStatistic', date);

    final List<int> dayOfMonth = List<int>.generate(
        DateUtils.getDaysInMonth(date.year, date.month), (index) => index + 1);

    final result = dayOfMonth
        .map((day) => DateTime(date.year, date.month, day).toIso8601String())
        .toList();
    log('testStatistic', result);
    return result;
  }

  static List<String> getListDayOfWeek(int subtractWeek) {
    final List<String> result = [];
    for (final day in [0, -1, -2, -3, -4, -5, -6]) {
      result.add(DateTime.now()
          .subtract(Duration(
              days: day +
                  (DateTime.now().weekday - DateTime.monday) +
                  subtractWeek * 7))
          .toIso8601String());
    }
    return result;
  }

  static bool isSameDay(DateTime dateTimeSource, DateTime dateTimeDestination) {
    return dateTimeSource.year == dateTimeDestination.year &&
        dateTimeSource.month == dateTimeDestination.month &&
        dateTimeSource.day == dateTimeDestination.day;
  }

  static int compareStringDay(String dateSource, String dateDestination) {
    final DateTime dateTimeSource = DateTime.parse(dateSource);
    final DateTime dateTimeDestination = DateTime.parse(dateDestination);

    return DateTime(
            dateTimeSource.year, dateTimeSource.month, dateTimeSource.day)
        .compareTo(DateTime(dateTimeDestination.year, dateTimeDestination.month,
            dateTimeDestination.day));
  }

  static int compareStringTime(String dateSource, String dateDestination) {
    final DateTime dateTimeSource = DateTime.parse(dateSource);
    final DateTime dateTimeDestination = DateTime.parse(dateDestination);

    return dateTimeSource.compareTo(dateTimeDestination);
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

  static bool isSameMonthString(String date, String dateDestination) {
    return DateTime.parse(date).year == DateTime.parse(dateDestination).year &&
        DateTime.parse(date).month == DateTime.parse(dateDestination).month;
  }

  static bool isInCurrentWeekString(String strDate) {
    final dateTime = DateTime.parse(strDate);
    final lastMonday = DateTime.now()
        .subtract(Duration(days: DateTime.now().weekday - DateTime.monday));
    log('date', dateTime);
    log('lastMonday', lastMonday);
    log('inDays', dateTime.difference(lastMonday).inDays);
    final int differenceDays = dateTime.difference(lastMonday).inDays;
    return differenceDays >= 0 && differenceDays < DateTime.daysPerWeek;
  }

  static bool isInCurrentMonthString(String date) {
    final dateTime = DateTime.parse(date);
    return dateTime.month == DateTime.now().month;
  }

  static bool isInCurrentYearString(String date) {
    final dateTime = DateTime.parse(date);
    return dateTime.year == DateTime.now().year;
  }

  //convert weekday of Datetime to custom weekday in file map_const.dart.
  static int convertStandardWeekdayToCustomWeekday(int weekday) {
    int customWeekday = weekday - 1;
    if (customWeekday == -1) {
      customWeekday = 6;
    }
    return customWeekday;
  }

  static int getCustomWeekdayFromString(String date) {
    return convertStandardWeekdayToCustomWeekday(DateTime.parse(date).weekday);
  }

  static bool isWithinWeekFromString(String date1, String date2) {
    return DateTime.parse(date1).day - DateTime.parse(date2).day <= 7;
  }
}
