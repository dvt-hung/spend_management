import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 1000000;
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
                buildTotalMoney(total),
                const SizedBox(
                  height: 20,
                ),
                // <---- Hiển thị tổng chi tiêu hôm nay ---->

                Container(
                  padding: const EdgeInsets.all(20.0),
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
                            Utils.convertCurrency(200000),
                            style: AppStyles.priceStyle_20,
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
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return ItemSpendToday(
                              imageItem: "assets/wallet.png",
                              titleItem: "Title",
                              priceItem: 100000,
                            );
                          }),
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

  Row buildTotalMoney(double total) {
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
                color: total > 0 ? Colors.green : Colors.red,
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

class ItemSpendToday extends StatelessWidget {
  const ItemSpendToday({
    Key? key,
    required this.imageItem,
    required this.titleItem,
    required this.priceItem,
  }) : super(key: key);
  final String imageItem;
  final String titleItem;
  final double priceItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imageItem,
        height: 30,
        width: 30,
      ),
      title: Text(
        titleItem,
        style: AppStyles.textStyle,
      ),
      trailing: Text(
        Utils.convertCurrency(priceItem),
        style: AppStyles.priceStyle_15,
      ),
    );
  }
}
