import 'package:intl/intl.dart';

class ChungAngTimeConverter {
  static DateTime parseTimeString(int year, int month, int day,String timeString) {
    int hour = 12;
    int minutes = 0;
    if (timeString.contains("am") || (timeString.contains("pm") && timeString.contains("12:"))) {
      timeString = timeString.replaceAll("am", "");
      timeString = timeString.replaceAll("pm", "");
      final tmp = timeString.split(":");
      hour = int.parse(tmp[0]);
      minutes = int.parse(tmp[1]);
    } else if (timeString.contains("pm")) {
      timeString = timeString.replaceAll("pm", "");
      final tmp = timeString.split(":");
      hour = int.parse(tmp[0]) + 12;
      minutes = int.parse(tmp[1]);
    }
    final res = DateTime(year, month, day, hour, minutes);
    return (DateTime.parse(formatDateTime(res)));
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").format(dateTime);
  }

  static int findFirstWeekday(DateTime date, int weekday) {
    // Find the first weekday of the month
    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }
    return date.day;
  }

  static int findFirstMondayOfTheMonth(int month, int year) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int firstMonday = findFirstWeekday(firstDayOfMonth, DateTime.monday);
    return firstMonday;
  }
}
