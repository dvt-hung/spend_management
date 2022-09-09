import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle titleStyle = GoogleFonts.patuaOne();

  static TextStyle textStyle = GoogleFonts.sarabun();

  static TextStyle priceStyle = GoogleFonts.sarabun()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);
}
