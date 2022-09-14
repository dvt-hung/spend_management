import 'package:flutter/material.dart';
import 'package:spend_management/utils/app_colors.dart';

class AppDialogs {
  static AlertDialog alertDialogProgress = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.all(10.0),
      height: 70,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 15,
          ),
          Text("Đợi trong giây lát..."),
        ],
      ),
    ),
  );
}
