import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/add_spending/spending_page.dart';
import 'package:spend_management/pages/history/history_controller.dart';
import 'package:spend_management/pages/history/history_page.dart';
import 'package:spend_management/pages/home/home_page.dart';
import 'package:spend_management/pages/splash/splash_page.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/utils.dart';

import 'dashbroad_controller.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({Key? key}) : super(key: key);

  final pages = [
    HomePage(),
    HistoryPage(),
  ];

  DashBoardController dashBroadController = Get.put(DashBoardController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      builder: (_) {
        return Scaffold(
          body: IndexedStack(
            index: dashBroadController.currentPage,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            unselectedItemColor: AppColors.disableColor,
            selectedItemColor: AppColors.whiteColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_sharp),
                label: "Lịch sử",
              ),
            ],
            onTap: (index) {
              dashBroadController.changePage(index);
            },
            currentIndex: dashBroadController.currentPage,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.selectColor,
            onPressed: () {
              Get.to(
                SpendingPage(
                  isDetail: false,
                  titleAppBar: "Thêm giao dịch",
                ),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
