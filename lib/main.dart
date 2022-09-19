import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/splash/splash_page.dart';
import 'firebase_options.dart';
import 'models/note_model.dart';
import 'models/type_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   MonthYearPickerLocalizations.delegate,
      // ],
    );
  }
}
