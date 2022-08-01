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
}
