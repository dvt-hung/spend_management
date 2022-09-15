import 'package:get/get.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/utils/app_colors.dart';

import '../../models/note_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/utils.dart';
import '../dashboard/dashbroad_page.dart';

class AddSpendingController extends GetxController {
  TypeModel type = TypeModel();

  void changeType(TypeModel typeModel) {
    type = typeModel;
    update(['updateType']);
  }

  Future addNote(double money, String note) async {
    NoteModel noteModel = NoteModel();
    noteModel.date = Utils.today;
    noteModel.note = note;
    noteModel.money = money;
    noteModel.type = type.toJson();

    Get.dialog(AppDialogs.alertDialogProgress);
    await ApiServices.addNote(noteModel, (result) {
      if (result) {
        Get.back();
        AppDialogs.showSnackBar(
            "Thông báo ", "Đã thêm mới thành công", SnackPosition.TOP);

        Get.offAll(DashBoardPage());
      } else {
        AppDialogs.showSnackBar(
            "Thông báo ", "Đã xảy ra lỗi", SnackPosition.TOP);

        Get.back();
      }
    });
  }
}
