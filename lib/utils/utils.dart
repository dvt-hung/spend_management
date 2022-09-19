import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spend_management/models/type_model.dart';

class Utils {
  //<----- VARIABLE ----->
  static int totalMoney = 0;
  static List<DateTime> monthsOfYear = [];

  // <---- GET TODAY---->

  static Timestamp today = Timestamp.now();

  static Timestamp startToday = Timestamp.fromDate(DateTime(
      today.toDate().year, today.toDate().month, today.toDate().day, 0, 0));

  static Timestamp endToday = Timestamp.fromDate(DateTime(today.toDate().year,
      today.toDate().month, today.toDate().day, 23, 59, 59));

  // <---- GET FIRST AND END DAY OF MONTH ---->
  // DateTime lastDayOfMonth =
  // new DateTime(now.year, 8 + 1, 0, 23, 59, 59);
  //
  // DateTime date = DateTime(now.year, 8, 1);
  static Timestamp getFirstDayOfMonth(int year, int month) {
    Timestamp firstDay = Timestamp.fromDate(DateTime(year, month, 1));

    return firstDay;
  }

  static Timestamp getLastDayOfMonth(int year, int month) {
    Timestamp lastDay =
        Timestamp.fromDate(DateTime(year, month + 1, 0, 23, 59, 59));

    return lastDay;
  }

  static String getStringToDay() {
    return DateFormat("dd - MM - yyyy").format(today.toDate());
  }

  static String convertDateToString(Timestamp timestamp) {
    String date = timestamp.toDate().day.toString().padLeft(2, '0') +
        " - " +
        timestamp.toDate().month.toString().padLeft(2, '0') +
        " - " +
        timestamp.toDate().year.toString();
    return date;
  }

  static String convertCurrency(int money) {
    return NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
        .format(money);
  }

  // <----- Pick image ---->
  static Future<File> pickerImage() async {
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pick!.path);
  }

// <----- List spend or income ---->
  static final groupType = ['Khoản thu', 'Chi tiêu'];
}
