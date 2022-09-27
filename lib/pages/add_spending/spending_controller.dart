import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/models/type_model.dart';

import '../../models/note_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/utils.dart';
import '../dashboard/dashbroad_controller.dart';
import '../dashboard/dashbroad_page.dart';
import '../history/history_controller.dart';
import '../home/home_controller.dart';

class SpendingController extends GetxController {
  // <---- Variable ---->
  TextEditingController moneyTextController = TextEditingController();
  TextEditingController noteTextController = TextEditingController();
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

  Future addNote(
    String money,
    String note,
  ) async {
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
      await ApiServices.addNote(
        noteModel,
        type,
        (result) {
          if (result) {
            AppDialogs.showSnackBar(
              "Thông báo ",
              "Đã thêm giao dịch thành công",
            );
            Get.delete<HomeController>();
            Get.delete<HistoryController>();
            Get.delete<DashBoardController>();
            Get.delete<SpendingController>();
            Get.to(DashBoardPage());
          } else {
            AppDialogs.showSnackBar(
              "Thông báo ",
              "Đã xảy ra lỗi",
            );
            Get.back();
          }
        },
      );
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
          AppDialogs.showSnackBar(
              "Thông báo", "Đã chỉnh sửa giao dịch thành công");
          Get.back();
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
    moneyTextController.clear();
    noteTextController.clear();
    // disposeScreen();
  }
}
