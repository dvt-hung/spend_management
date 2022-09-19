import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/components/input_component.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/pages/add_spending/spending_controller.dart';
import 'package:spend_management/pages/dashboard/dashbroad_page.dart';

import 'package:spend_management/pages/types/types_page.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_dialogs.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/app_urls.dart';
import 'package:spend_management/utils/utils.dart';

class SpendingPage extends StatelessWidget {
  SpendingPage({Key? key, required this.isDetail, required this.titleAppBar})
      : super(key: key);
  String titleAppBar;
  bool isDetail = false;

  SpendingController addSpendingController = Get.put(SpendingController());

  TextEditingController moneyTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  TypeModel typeOld = TypeModel();
  int moneyOld = 0;
  @override
  Widget build(BuildContext context) {
    typeOld = addSpendingController.type;
    if (addSpendingController.noteModel.money != null) {
      moneyTextController.text =
          addSpendingController.noteModel.money!.toString();
      moneyOld = addSpendingController.noteModel.money!;
    }
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        addSpendingController.onClose();
        return false;
      },
      child: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        titleAppBar,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          addSpendingController.onClose();
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.whiteColor,
        ),
      ),
      actions: [
        isDetail
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      AppDialogs.showDialogDelete(() {
                        addSpendingController.deleteNote();
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      int moneyNew = int.parse(moneyTextController.text);
                      addSpendingController.updateNote(
                          moneyNew, moneyOld, typeOld);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              )
            : IconButton(
                onPressed: () {
                  String note = noteTextController.text;
                  addSpendingController.addNote(moneyTextController.text, note);
                },
                icon: const Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                ),
              ),
      ],
    );
  }

  Container buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondColor,
            AppColors.primaryColor,
            AppColors.whiteColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: GetBuilder<SpendingController>(
                id: 'updateType',
                builder: (_) {
                  return Column(
                    children: [
                      Text(
                        addSpendingController.noteModel.date == null
                            ? Utils.getStringToDay()
                            : Utils.convertDateToString(
                                addSpendingController.noteModel.date!),
                        style: AppStyles.titleStyle.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      inputMoney(),
                      const SizedBox(
                        height: 20,
                      ),
                      inputType(),
                      const SizedBox(
                        height: 20,
                      ),
                      inputNote(),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }

  InputComponent inputNote() {
    return InputComponent(
      controller: noteTextController,
      iconInput: AppUrls.urlIconNote,
      hinText: addSpendingController.noteModel.note.toString().isEmpty ||
              addSpendingController.noteModel.note == null
          ? "Ghi chú thêm"
          : addSpendingController.noteModel.note.toString(),
      colorHintTextInput: AppColors.whiteColor,
      colorTextInput: AppColors.whiteColor,
      maxLine: 1,
    );
  }

  InputComponent inputType() {
    return InputComponent(
      readOnly: true,
      hinText: addSpendingController.type.contentType == null
          ? "Chọn nhóm chi tiêu "
          : addSpendingController.type.contentType.toString(),
      iconInput: addSpendingController.type.urlType,
      onTap: () {
        Get.to(() => TypesPage());
      },
      colorHintTextInput: AppColors.whiteColor,
    );
  }

  InputComponent inputMoney() {
    return InputComponent(
      controller: moneyTextController,
      iconInput: AppUrls.urlIconMoney,
      hinText: "0 đ",
      // Nếu là khoản thu thì text color = Green | chi tiêu thì text color = Red
      colorHintTextInput: AppColors.greenColor,
      colorTextInput: AppColors.greenColor,
      fontWeightHintTextInput: FontWeight.bold,
      fontSizeTextInput: 30,
      fontSizeHintTextInput: 30,
      textInputType: TextInputType.number,
    );
  }
}
