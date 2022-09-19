import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/history/history_controller.dart';
import 'package:spend_management/utils/app_colors.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: TextButton(
          onPressed: historyController.pickerMonth,
          child: Text("Show"),
        ),
      ),
    );
  }
}
