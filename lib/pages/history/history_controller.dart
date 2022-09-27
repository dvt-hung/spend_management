import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/app_dialogs.dart';
import 'package:spend_management/utils/utils.dart';

import '../../models/type_model.dart';

class HistoryController extends GetxController {
  // <--- Variable --->
  // Check first load data
  List<Map<String, dynamic>> listNoteType = [];
  List<List<Map<String, dynamic>>> listResult = [];
  // Page view controller
  PageController pageViewController =
      PageController(viewportFraction: 1, keepPage: true);

  final ItemScrollController itemScrollController = ItemScrollController();

  // <--- Variable Test --->

  // <----- Function ----->
  Future scrollToIndex(int index) async {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn);
  }

  // onChangePage: thay đổi trang hiển thị note
  Future onChangePage(int index) async {
    scrollToIndex(index);

    pageViewController.jumpToPage(index);

    Utils.selectIndexListMonthOfYear = index;
    await filterNoteByMonth();
    update(['updateView']);
  }

  // Lấy ra danh sách Note theo tháng
  Future filterNoteByMonth() async {
    print("run");
    DateTime time = Utils.monthsOfYear[Utils.selectIndexListMonthOfYear];
    final notes = listNoteType.where((element) {
      NoteModel noteModel = element['note'];
      return noteModel.date!.toDate().month == time.month;
    }).toList();
    update(['updateData']);

    await getDateOfMonthHasNote(notes);
  }

  // Lấy ra các ngày có Note trong tháng
  Future getDateOfMonthHasNote(List<Map<String, dynamic>> listNoteType) async {
    List<DateTime> dateOfMonth = [];

    // Nếu mảng đang lớn hơn 2 phần tử
    if (listNoteType.length > 1) {
      // Tạo note lưu trữ giá trị đầu index = 0
      NoteModel noteTemp = listNoteType[0]['note'];

      // Thêm note đầu vào mảng dateOfMonth
      dateOfMonth.add(noteTemp.date!.toDate());
      // Duyệt từ cuối mảng trở về

      for (var i = 1; i < listNoteType.length; i++) {
        NoteModel noteCurrent = listNoteType[i]['note'];

        // Kiểm tra note hiện tại với note temp có khác ngày với nhau hay không
        bool isCompare =
            noteCurrent.date!.toDate().day != noteTemp.date!.toDate().day;

        // Nếu note hiện tại đang xét có ngày khác với note temp thì thêm vào mảng
        if (isCompare) {
          dateOfMonth.add(noteCurrent.date!.toDate());
          // Cập nhật lại note temp
          noteTemp = noteCurrent;
        }
      }
    }
    // Nếu mảng chỉ có một phần tử
    else if (listNoteType.length == 1) {
      NoteModel noteTemp = listNoteType[0]['note'];
      dateOfMonth.add(noteTemp.date!.toDate());
    }
    await filterNoteByDateOfMonth(dateOfMonth, listNoteType);
  }

  // Lấy ra Note theo ngày
  Future filterNoteByDateOfMonth(
      List<DateTime> dates, List<Map<String, dynamic>> listNoteType) async {
    listResult.clear();
    for (var date in dates) {
      final temp = listNoteType.where((element) {
        NoteModel noteTemp = element['note'];

        return noteTemp.date!.toDate().day == date.day;
      }).toList();
      listResult.add(temp);
    }
    update(['updateData']);
  }

  void getData() async {
    await ApiServices.getAllNote2((value) async {
      listNoteType = value;

      update(['updateData']);

      await filterNoteByMonth();
    });
  }

  @override
  void onReady() async {
    super.onReady();
    initializeDateFormatting();
    getData();

    onChangePage(Utils.selectIndexListMonthOfYear);
  }

  int sum(NoteModel note, TypeModel type) {
    int sum = 0;
    if (type.groupType == "Khoản thu") {
      sum += note.money!.toInt();
    } else {
      sum -= note.money!.toInt();
    }
    update(['updateSum']);
    return sum;
  }
}
