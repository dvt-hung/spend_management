class Utils {
  static String getStringToDay() {
    DateTime today = DateTime.now();
    String dateToday = today.day.toString().padLeft(2, '0') +
        " - " +
        today.month.toString().padLeft(2, '0') +
        " - " +
        today.year.toString();
    return dateToday;
  }
}
