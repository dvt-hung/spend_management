import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/utils.dart';

import '../../models/type_model.dart';

class HistoryController extends GetxController {
  // <--- Variable --->

  List<NoteModel> noteByMonth = [];
  List<DateTime> dateOfMonth = [];
  List<List<NoteModel>> listNoteByDateOfMonth = [];

  PageController pageViewController =
      PageController(viewportFraction: 1, keepPage: true);

  final ItemScrollController itemScrollController = ItemScrollController();

  // <--- Variable Test --->
  List<Map<String, dynamic>> noteByMonth2 = [];
  List<List<Map<String, dynamic>>> listNoteByDateOfMonth2 = [];

  // <----- Function ----->
  Future scrollToIndex(int index) async {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic);
    Utils.selectIndexListMonthOfYear = index;
  }

  // onChangePage: thay đổi trang hiển thị note
  void onChangePage(int index) async {
    pageViewController.jumpToPage(index);

    scrollToIndex(index);

    Utils.selectIndexListMonthOfYear = index;

    await getNoteByMonth();

    // await getNoteByMonthV2();
    update(['updateView']);
  }

  // getNoteByMonth: Lấy ra danh sách các note theo tháng
  Future getNoteByMonth() async {
    DateTime time = Utils.monthsOfYear[Utils.selectIndexListMonthOfYear];

    await ApiServices.getNoteByMonth(
      time.month,
      time.year,
      (result) async {
        List<dynamic> temp = result;
        noteByMonth.clear();
        dateOfMonth.clear();

        for (var element in temp) {
          noteByMonth.add(NoteModel.fromJon(element));
        }
        getDateOfMonth(noteByMonth);
        await getListNoteByDate(dateOfMonth);

        update(['updateData']);
        // print("-------TEST----------");
      },
    );
  }

  Future getNoteByMonthV2() async {
    DateTime time = Utils.monthsOfYear[Utils.selectIndexListMonthOfYear];

    await ApiServices.getNoteByMonth(
      time.month,
      time.year,
      (result) async {
        List<dynamic> temp = result;
        dateOfMonth.clear();
        noteByMonth2.clear();

        for (var element in temp) {
          NoteModel noteCurrent = NoteModel.fromJon(element);

          TypeModel typeCurrent =
              await ApiServices.getSingleType(noteCurrent.type.toString());

          noteByMonth2.add(
            {
              'note': noteCurrent,
              'type': typeCurrent,
            },
          );
        }
        getDateOfMonthV2(noteByMonth2);
        getListNoteByDateV2();

        //
        update(['updateData']);
        // print("-------TEST----------");
      },
    );
  }

  // getDateOfMonth: lấy ra danh sách ngày có lưu note trong tháng
  void getDateOfMonth(List<NoteModel> noteByMonth) {
    // Nếu mảng đang lớn hơn 2 phần tử
    if (noteByMonth.length > 1) {
      // Tạo note lưu trữ giá trị đầu index = 0
      NoteModel noteTemp = noteByMonth[0];

      // Thêm note đầu vào mảng dateOfMonth
      dateOfMonth.add(noteTemp.date!.toDate());
      // Duyệt từ cuối mảng trở về

      for (var i = 1; i < noteByMonth.length; i++) {
        NoteModel noteCurrent = noteByMonth[i];

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
    else if (noteByMonth.length == 1) {
      NoteModel noteTemp = noteByMonth[0];
      dateOfMonth.add(noteTemp.date!.toDate());
    }
  }

  void getDateOfMonthV2(List<Map<String, dynamic>> noteByMonth2) {
    // Nếu mảng đang lớn hơn 2 phần tử
    if (noteByMonth2.length > 1) {
      // Tạo note lưu trữ giá trị đầu index = 0
      NoteModel noteTemp = noteByMonth2[0]['note'];

      // Thêm note đầu vào mảng dateOfMonth
      dateOfMonth.add(noteTemp.date!.toDate());
      // Duyệt từ cuối mảng trở về

      for (var i = 1; i < noteByMonth2.length; i++) {
        NoteModel noteCurrent = noteByMonth2[i]['note'];

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
    else if (noteByMonth2.length == 1) {
      NoteModel noteTemp = noteByMonth2[0]['note'];
      dateOfMonth.add(noteTemp.date!.toDate());
    }
  }

  // getListNoteByDate: Lấy ra danh sách các note có trong 1 ngày của tháng nào đó
  Future getListNoteByDate(List<DateTime> month) async {
    listNoteByDateOfMonth.clear();
    for (var data in month) {
      List<NoteModel> listNoteTemp = [];
      listNoteTemp = noteByMonth
          .where((element) => element.date!.toDate().day == data.day)
          .toList();

      listNoteByDateOfMonth.add(listNoteTemp);
    }
  }

  getListNoteByDateV2() {
    listNoteByDateOfMonth2.clear();
    for (var data in dateOfMonth) {
      List<Map<String, dynamic>> listNoteTemp = [];

      listNoteTemp = noteByMonth2.where((element) {
        return element['note'].date!.toDate().day == data.day;
      }).toList();
      NoteModel a = listNoteTemp[0]['note'];

      listNoteByDateOfMonth2.add(listNoteTemp);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    initializeDateFormatting();
    onChangePage(Utils.selectIndexListMonthOfYear);
  }
}
