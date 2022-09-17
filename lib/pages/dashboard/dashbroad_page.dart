import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/add_spending/add_spending_page.dart';
import 'package:spend_management/pages/history/history_page.dart';
import 'package:spend_management/pages/home/home_page.dart';
import 'package:spend_management/pages/splash/splash_page.dart';
import 'package:spend_management/utils/app_colors.dart';

import 'dashbroad_controller.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({Key? key}) : super(key: key);

  final pages = [
    HomePage(),
    const HistoryPage(),
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
            unselectedItemColor: Colors.black,
            selectedItemColor: AppColors.primaryColor,
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
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              Get.to(
                AddSpendingPage(
                  isDetail: false,
                  titleAppBar: "Thêm giao dịch",
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
