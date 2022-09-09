import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_management/pages/home/home_page.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.off(
        const HomePage(),
      ),
    );
    DateTime today = DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    print(dateSlug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/splash.json"),
            const SpinKitFadingCircle(
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
