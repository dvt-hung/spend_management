import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/pages/home/home_controller.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/utils.dart';

import '../../components/item_note_component.dart';
import '../../components/note_block_component.dart';
import '../../models/type_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // <---- Hiển thị tổng tiền đang có ---->
                  GetBuilder<HomeController>(
                    id: 'totalMoney',
                    builder: (_) {
                      return buildTotalMoney(Utils.totalMoney);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<HomeController>(
                    id: 'getToday',
                    builder: (_) {
                      return Column(
                        children: [
                          NoteBlock(
                              listItem: homeController.mapNoteSpending,
                              money: homeController.spendingMoney,
                              title: "Chi tiêu hôm nay",
                              styleMoney: AppStyles.priceStyleSpending20),
                          const SizedBox(
                            height: 20.0,
                          ),
                          NoteBlock(
                              listItem: homeController.mapNoteIncome,
                              money: homeController.incomeMoney,
                              title: "Khoản thu hôm nay",
                              styleMoney: AppStyles.priceStyleIncome20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildTotalMoney(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.convertCurrency(total),
              style: AppStyles.priceStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: total <= 0 ? AppColors.redColor : AppColors.whiteColor,
              ),
            ),
            Text(
              "Tổng số dư",
              style: AppStyles.textStyle
                  .copyWith(fontSize: 15, color: AppColors.whiteColor),
            ),
          ],
        ),
      ],
    );
  }
}
