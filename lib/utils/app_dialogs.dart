import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/utils/app_colors.dart';

import 'app_styles.dart';

class AppDialogs {
  static showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.whiteColor,
        snackPosition: SnackPosition.TOP);
  }

  static showDialogProgress() {
    Get.dialog(
      const ProgressDialog(),
    );
  }

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

  // <--- Show dialog confirm delete --->
  static showDialogDelete(Function onDelete) {
    Get.dialog(
      DialogDelete(onDelete: onDelete),
    );
  }
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
}

// <--- Dialog Confirm Delete --->
class DialogDelete extends StatelessWidget {
  const DialogDelete({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
            height: 160,
            child: Column(
              children: [
                Text(
                  "Bạn có chắc là xóa không?",
                  style: AppStyles.titleStyle.copyWith(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Hủy",
                        style: TextStyle(
                            color: AppColors.thirdColor, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete();
                        // print("delete");
                      },
                      child: const Text(
                        "Xác nhận",
                        style: TextStyle(
                            color: AppColors.selectColor, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              minRadius: 40,
              maxRadius: 40,
              child: Image.asset(
                "assets/warning.png",
                width: 50,
                height: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}
