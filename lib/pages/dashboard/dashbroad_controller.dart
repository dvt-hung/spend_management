import 'package:get/get.dart';

import '../../utils/utils.dart';

class DashBoardController extends GetxController {
  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("LOOP");
    Utils.monthsOfYear.forEach((element) {
      print(element);
    });
  }
}
