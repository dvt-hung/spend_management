import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spend_management/models/type_model.dart';

class Utils {
  static int totalMoney = 0;

  static Timestamp today = Timestamp.now();

  static Timestamp startToday = Timestamp.fromDate(DateTime(
      today.toDate().year, today.toDate().month, today.toDate().day, 0, 0));

  static Timestamp endToday = Timestamp.fromDate(DateTime(today.toDate().year,
      today.toDate().month, today.toDate().day, 23, 59, 59));

  static String getStringToDay() {
    String dateToday = today.toDate().day.toString().padLeft(2, '0') +
        " - " +
        today.toDate().month.toString().padLeft(2, '0') +
        " - " +
        today.toDate().year.toString();
    return dateToday;
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
