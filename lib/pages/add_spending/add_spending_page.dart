import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/components/input_component.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/pages/add_spending/add_spending_controller.dart';
import 'package:spend_management/pages/dashboard/dashbroad_page.dart';

import 'package:spend_management/pages/types/types_page.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_dialogs.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/app_urls.dart';
import 'package:spend_management/utils/utils.dart';

class AddSpendingPage extends StatelessWidget {
  AddSpendingPage({Key? key}) : super(key: key);

  AddSpendingController addSpendingController =
      Get.put(AddSpendingController());

  TextEditingController moneyTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: const Text(
            "Thêm giao dịch",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => DashBoardPage());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  double money = double.parse(moneyTextController.text);
                  String note = noteTextController.text;
                  addSpendingController.addNote(money, note);
                },
                child: const Text(
                  "Lưu",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: GetBuilder<AddSpendingController>(
            id: 'updateType',
            builder: (_) {
              return Column(
                children: [
                  Text(
                    Utils.getStringToDay(),
                    style: AppStyles.titleStyle.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  inputType(),
                  const SizedBox(
                    height: 20,
                  ),
                  inputMoney(),
                  const SizedBox(
                    height: 20,
                  ),
                  inputNote(),
                ],
              );
            },
          ),
        ));
  }

  Input_Component inputNote() {
    return Input_Component(
      controller: noteTextController,
      iconInput: AppUrls.urlIconNote,
      hinText: "Ghi chú thêm",
      colorHintTextInput: Colors.black,
      maxLine: 1,
    );
  }

  Input_Component inputType() {
    return Input_Component(
      readOnly: true,
      hinText: addSpendingController.type.contentType == null
          ? "Chọn nhóm chi tiêu "
          : addSpendingController.type.contentType.toString(),
      iconInput: addSpendingController.type.urlType,
      onTap: () {
        Get.to(() => TypesPage());
      },
    );
  }

  Input_Component inputMoney() {
    return Input_Component(
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
