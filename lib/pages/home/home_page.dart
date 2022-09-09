import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/util.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // <---- Hiển thị tổng tiền đang có ---->
                buildTotalMoney(),
                const SizedBox(
                  height: 20,
                ),
                // <---- Hiển thị tổng chi tiêu hôm nay ---->

                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chi tiêu hôm nay ",
                            style: AppStyles.textStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "200.000",
                            style: AppStyles.priceStyle,
                          )
                        ],
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                        height: 20,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTotalMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "100.000.000 ",
              style: AppStyles.titleStyle.copyWith(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            Text(
              "Tổng số dư",
              style: AppStyles.textStyle
                  .copyWith(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            "assets/wallet.png",
            height: 40,
            width: 40,
          ),
        ),
      ],
    );
  }
}
