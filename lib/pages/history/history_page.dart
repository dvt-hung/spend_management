import 'package:flutter/material.dart';
import 'package:spend_management/utils/app_colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Text("History Page"),
      ),
    );
  }
}
