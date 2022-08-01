import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  static DateTime get today => DateTime.now();
  static DateTime get tomorrow => DateTime.now().add(const Duration(days: 1));

  bool isToday() => isSameDay(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  bool isTomorrow() => isSameDay(DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));

  bool isSameDay(DateTime date) {
    DateTime today = DateTime(year, month, day);

    return today == DateTime(date.year, date.month, date.day);
  }

  bool isSameWeek(DateTime dateTime) {
    return ((int.parse(DateFormat("D").format(dateTime)) -
                    dateTime.weekday +
                    10) /
                7)
            .floor() ==
        ((int.parse(DateFormat("D").format(this)) - dateTime.weekday + 10) / 7)
            .floor();
  }

  String formatNotesDate() {
    if (isToday()) {
      return 'Today, ${DateFormat.Hm().format(this)}';
    } else if (isTomorrow()) {
      return 'Tomorrow, ${DateFormat.Hm().format(this)}';
    } else if (isSameWeek(DateTime.now())) {
      return DateFormat("E, HH:mm").format(this);
    } else {
      return DateFormat("d MMM, HH:mm").format(this);
    }
  }
}
