import 'package:get/get.dart';
import 'package:spend_management/models/type_model.dart';

import '../../models/note_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/utils.dart';
import '../dashboard/dashbroad_page.dart';

class SpendingController extends GetxController {
  // <---- Variable ---->
  TypeModel type = TypeModel();
  NoteModel noteModel = NoteModel();
  void changeType(TypeModel typeModel) {
    type = typeModel;
    update(['updateType']);
  }

  // <---- Function ---->
  Future deleteNote() async {
    Get.dialog(AppDialogs.alertDialogProgress);
    await ApiServices.deleteNote(noteModel, type, (result) {
      if (result) {
        Get.back();
        AppDialogs.showSnackBar("Thông báo", "Đã xóa thành công giao dịch");
        Get.offAll(() => DashBoardPage());
      } else {
        AppDialogs.showSnackBar("Thông báo", "Đã xảy ra lỗi!!!");
        Get.back();
      }
    });
  }

  Future addNote(String money, String note) async {
    if (type.idType == null || money.isEmpty) {
      AppDialogs.showSnackBar(
        "Thông báo ",
        "Dữ liệu đang bị bỏ trống!",
      );
    } else {
      noteModel.date = Utils.today;
      noteModel.note = note;
      noteModel.money = int.parse(money);
      noteModel.type = type.idType;

      Get.dialog(AppDialogs.alertDialogProgress);
      await ApiServices.addNote(noteModel, type, (result) {
        if (result) {
          Get.back();
          AppDialogs.showSnackBar(
            "Thông báo ",
            "Đã thêm mới thành công",
          );

          Get.offAll(DashBoardPage());
        } else {
          AppDialogs.showSnackBar(
            "Thông báo ",
            "Đã xảy ra lỗi",
          );
          Get.back();
        }
      });
    }
  }

  Future updateNote(
    int moneyNew,
    int moneyOld,
    TypeModel typeOld,
  ) async {
    noteModel.money = moneyNew;

    AppDialogs.showDialogProgress();
    await ApiServices.updateNote(
      noteModel,
      type,
      typeOld,
      moneyOld,
      (result) {
        if (result) {
          Get.back();
          Get.offAll(() => DashBoardPage());
          AppDialogs.showSnackBar(
              "Thông báo", "Đã chỉnh sửa giao dịch thành công");
        } else {
          AppDialogs.showSnackBar("Thông báo", "Đã có lỗi xảy ra!");
          Get.back();
        }
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    type = TypeModel();
    noteModel = NoteModel();
    // disposeScreen();
  }

  Future disposeScreen() async {
    super.onClose();
    type = TypeModel();
    noteModel = NoteModel();
  }
}
