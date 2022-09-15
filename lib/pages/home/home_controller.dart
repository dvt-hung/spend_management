import 'package:get/get.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/utils.dart';

class HomeController extends GetxController {
  getTotalMoney() async {
    await ApiServices.getTotalMoney(
      (data) {
        Utils.totalMoney = data['total'] * 1.0;
        update(['totalMoney']);
      },
    );
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getTotalMoney();
  }
}
