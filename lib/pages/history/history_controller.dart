import 'package:get/get.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:spend_management/utils/utils.dart';

class HistoryController extends GetxController {
  void pickerMonth() async {
    print("-------------------------");
    print(
        "Month current: ${Utils.monthsOfYear[Utils.today.toDate().month - 1]}");
    print("-------------------------");
    // final selected = await showMonthPicker(
    //     context: Get.context!,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(1970),
    //     lastDate: DateTime(2050));
    // print(
    //     "Month/Year: ${selected!.month.toString()}/${selected.year.toString()} ");
  }
}
