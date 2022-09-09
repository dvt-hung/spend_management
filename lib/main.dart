import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/home/home_page.dart';
import 'package:spend_management/pages/splash/splash_page.dart';
import 'package:spend_management/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
