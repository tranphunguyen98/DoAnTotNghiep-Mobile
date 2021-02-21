import 'package:intl/intl.dart';

class Util {
  static String getDisplayTextDateFromDate(String dateTime) {
    if (dateTime != null && dateTime.isNotEmpty) {
      final date = DateTime.parse(dateTime);
      if (date.compareTo(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          )) ==
          0) {
        return "To Day";
      } else {
        return DateFormat("dd/MM/yyyy").format(date);
      }
    }
    return null;
  }
}
