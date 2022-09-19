import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle priceStyle = GoogleFonts.notoSans();

  static TextStyle titleStyle = GoogleFonts.notoSans();

  static TextStyle textStyle = GoogleFonts.notoSans();

  // Text style of price (spending) font size = 15
  static TextStyle priceStyleSpending15 = GoogleFonts.notoSans()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red);

  // Text style of price (spending) font size = 20
  static TextStyle priceStyleSpending20 = GoogleFonts.notoSans()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);

  // Text style of price (spending) font size = 15
  static TextStyle priceStyleIncome15 = GoogleFonts.notoSans()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green);

  // Text style of price (spending) font size = 20
  static TextStyle priceStyleIncome20 = GoogleFonts.notoSans()
      .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green);
}
