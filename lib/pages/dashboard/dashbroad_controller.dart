import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/utils.dart';
import '../history/history_controller.dart';

class DashBoardController extends GetxController {
  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // Compare month and year current in list
    for (var index = 0; index < Utils.monthsOfYear.length; index++) {
      bool isCurrent =
          Utils.today.toDate().month == Utils.monthsOfYear[index].month &&
              Utils.today.toDate().year == Utils.monthsOfYear[index].year;

      if (isCurrent) {
        Utils.selectIndexListMonthOfYear = index;
        break;
      }
    }
  }
}
