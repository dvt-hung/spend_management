import 'package:get/get.dart';
import 'package:spend_management/pages/home/home_controller.dart';

import '../../utils/utils.dart';
import '../dashboard/dashbroad_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    for (var i = 8; i <= 12; i++) {
      DateTime month = DateTime(Utils.today.toDate().year - 1, i);
      Utils.monthsOfYear.add(month);
    }

    for (var i = 1; i <= 12; i++) {
      DateTime month = DateTime(Utils.today.toDate().year, i);

      Utils.monthsOfYear.add(month);
    }

    Future.delayed(const Duration(seconds: 2), () {
      return Get.offAll(() => DashBoardPage());
    });
  }
}
