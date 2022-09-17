import 'package:get/get.dart';

class DashBoardController extends GetxController {
  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    update();
  }
}
