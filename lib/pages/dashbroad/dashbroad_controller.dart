import 'package:get/get.dart';

class DashBroadController extends GetxController {
  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    update();
  }
}
