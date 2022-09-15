import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spend_management/models/type_model.dart';

class Utils {
  static double totalMoney = 0.0;

  static DateTime today = DateTime.now();

  static String getStringToDay() {
    String dateToday = today.day.toString().padLeft(2, '0') +
        " - " +
        today.month.toString().padLeft(2, '0') +
        " - " +
        today.year.toString();
    return dateToday;
  }

  static String convertCurrency(double money) {
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
