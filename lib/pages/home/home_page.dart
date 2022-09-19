import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/pages/home/home_controller.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/utils.dart';

import '../../components/item_note_component.dart';
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
                      }),
                  const SizedBox(
                    height: 20,
                  ),

                  // <---- Hiển thị tổng chi tiêu hôm nay ---->
                  GetBuilder<HomeController>(
                      id: 'getToday',
                      builder: (_) {
                        return Column(
                          children: [
                            buildNoteContainer(
                                homeController.mapNoteSpending,
                                homeController.spendingMoney,
                                "Chi tiêu hôm nay",
                                AppStyles.priceStyleSpending20),
                            const SizedBox(
                              height: 20.0,
                            ),
                            buildNoteContainer(
                                homeController.mapNoteIncome,
                                homeController.incomeMoney,
                                "Khoản thu hôm nay",
                                AppStyles.priceStyleIncome20),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildNoteContainer(List<Map<String, dynamic>> listItem, int money,
      String title, TextStyle styleMoney) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.textStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                Utils.convertCurrency(money),
                style: styleMoney,
              )
            ],
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            height: 20,
            // color: Colors.amber,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                // Get note model
                NoteModel noteModel = listItem[index]['note'];

                // Get type model
                TypeModel typeModel = listItem[index]['type'];
                return ItemNote(
                  noteModel: noteModel,
                  typeModel: typeModel,
                );
              }),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
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
                color: total > 0 ? AppColors.whiteColor : AppColors.thirdColor,
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
