import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_urls.dart';
import 'package:spend_management/utils/utils.dart';

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

  static showDetailNote(NoteModel note, TypeModel type) {
    Get.dialog(DialogInfoNote(
      noteModel: note,
      typeModel: type,
    ));
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

// <--- Dialog Info Note --->
class DialogInfoNote extends StatelessWidget {
  const DialogInfoNote({
    required this.noteModel,
    required this.typeModel,
    Key? key,
  }) : super(key: key);

  final NoteModel noteModel;
  final TypeModel typeModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.none,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  children: [
                    Text(
                      typeModel.groupType.toString(),
                      style: AppStyles.titleStyle.copyWith(
                          color: typeModel.groupType == Utils.groupType[0]
                              ? AppColors.greenColor
                              : AppColors.redColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Vào lúc: ${Utils.formatTime.format(noteModel.date!.toDate())}",
                      style: AppStyles.titleStyle.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 5.0, top: 5.0),
                  child: Column(
                    children: [
                      // <--- Loại chi tiêu --->
                      ListTile(
                        title: Text(typeModel.contentType.toString()),
                        leading: CachedNetworkImage(
                          imageUrl: typeModel.urlType.toString(),
                          placeholder: (context, url) =>
                              const SizedBox.shrink(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.question_mark),
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // <--- Số tiền --->
                      ListTile(
                        title: Text(
                          Utils.convertCurrency(noteModel.money!.toInt()),
                          style: typeModel.groupType == Utils.groupType[0]
                              ? AppStyles.priceStyleIncome15
                              : AppStyles.priceStyleSpending15,
                        ),
                        leading: CachedNetworkImage(
                          imageUrl: AppUrls.urlIconMoney,
                          placeholder: (context, url) =>
                              const SizedBox.shrink(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.question_mark),
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // <--- Ghi chú --->
                      ListTile(
                        title: noteModel.note.toString().isNotEmpty
                            ? Text(noteModel.note.toString())
                            : const Text(
                                "Không có ghi chú",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                        leading: CachedNetworkImage(
                          imageUrl: AppUrls.urlIconNote,
                          placeholder: (context, url) =>
                              const SizedBox.shrink(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.question_mark),
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
