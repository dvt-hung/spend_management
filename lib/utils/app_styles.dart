import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle priceStyle = GoogleFonts.sarabun();

  static TextStyle titleStyle = GoogleFonts.notoSans();

  static TextStyle textStyle = GoogleFonts.raleway();

  static TextStyle priceStyle_20 = GoogleFonts.sarabun()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);

  static TextStyle priceStyle_15 = GoogleFonts.sarabun()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red);
}
