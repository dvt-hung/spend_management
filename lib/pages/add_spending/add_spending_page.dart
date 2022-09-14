import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/components/input_component.dart';
import 'package:spend_management/pages/add_spending/add_spending_controller.dart';
import 'package:spend_management/pages/dashbroad/dashbroad_page.dart';
import 'package:spend_management/pages/types/types_page.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/app_urls.dart';
import 'package:spend_management/utils/utils.dart';

class AddSpendingPage extends StatelessWidget {
  AddSpendingPage({Key? key}) : super(key: key);

  AddSpendingController addSpendingController =
      Get.put(AddSpendingController());

  TextEditingController moneyTextController = TextEditingController();
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
              Get.offAll(() => DashBroadPage());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.blackColor,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {},
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
          child: Column(
            children: [
              Text(
                Utils.getStringToDay(),
                style: AppStyles.titleStyle.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 15,
                thickness: 2.0,
                indent: 15.0,
                endIndent: 15.0,
              ),
              Input_Component(
                iconInput: AppUrls.urlIconMoney,
                hinText: "Số tiền đã chi",
                colorHintTextInput: AppColors.greenColor,
                colorTextInput: AppColors.greenColor,
                fontWeightHintTextInput: FontWeight.bold,
                fontSizeTextInput: 30,
                fontSizeHintTextInput: 30,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<AddSpendingController>(
                  id: 'updateType',
                  builder: (_) {
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
                  }),
              const SizedBox(
                height: 20,
              ),
              Input_Component(
                iconInput: AppUrls.urlIconNote,
                hinText: "Ghi chú thêm",
                colorHintTextInput: Colors.black,
                maxLine: 1,
              ),
            ],
          ),
        ));
  }
}
