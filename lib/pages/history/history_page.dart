import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/pages/history/history_controller.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/utils.dart';

import '../../components/item_note_component.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  HistoryController historyController = Get.put(HistoryController());

  TypeModel typeModel = TypeModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }

  //<---------------------- App Bar ---------------------->
  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: GetBuilder<HistoryController>(
        id: 'updateView',
        builder: (_) {
          return ScrollablePositionedList.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Utils.monthsOfYear.length,
            itemScrollController: historyController.itemScrollController,
            itemBuilder: (context, index) {
              // Convert date to string
              String title =
                  DateFormat("MM-yyyy").format(Utils.monthsOfYear[index]);
              return GestureDetector(
                onTap: () {
                  historyController.onChangePage(index);
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 5.0, top: 10.0),
                  decoration: BoxDecoration(
                      color: Utils.selectIndexListMonthOfYear == index
                          ? AppColors.whiteColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Text(title),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //<---------------------- Body ---------------------->

  Widget buildBody() {
    return PageView.builder(
      controller: historyController.pageViewController,
      itemCount: Utils.monthsOfYear.length,
      onPageChanged: (int index) {
        historyController.onChangePage(index);
      },
      itemBuilder: (context, index) {
        return buildItemPageView();
      },
    );
  }

  // <----- PageView ----->
  Widget buildItemPageView() {
    return GetBuilder<HistoryController>(
      id: 'updateData',
      builder: (_) {
        return historyController.listResult.isNotEmpty
            ? buildListNote()
            : Center(
                child: Lottie.asset("assets/no-data.json"),
              );
      },
    );
  }

  // <----- ListNote: danh sách các ngày có Note trong tháng ----->
  Widget buildListNote() {
    List<List<Map<String, dynamic>>> listNote = historyController.listResult;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listNote.length,
      itemBuilder: (context, index) {
        // Get list noteModel by index

        List<Map<String, dynamic>> listNoteModelCurrent = listNote[index];

        // Get time display title
        DateTime time = listNoteModelCurrent[0]['note'].date!.toDate();

        return buildItemNote(time, listNoteModelCurrent);
      },
    );
  }

  // <----- ItemNote: Hiển thị ngày tháng năm item có Note trong tháng ----->
  Container buildItemNote(
      DateTime time, List<Map<String, dynamic>> listNoteModelCurrent) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.whiteColor,
      ),
      child: buildExpansionItemNote(time, listNoteModelCurrent),
    );
  }

  // <----- ExpansionItemNote: Hiển thị item có Note trong ngày ----->
  ExpansionTile buildExpansionItemNote(
      DateTime time, List<Map<String, dynamic>> listNoteModelCurrent) {
    int totalInDate = getTotal(listNoteModelCurrent);
    return ExpansionTile(
      title: Text(Utils.formatFullDate.format(time)),
      subtitle: Text(
        Utils.convertCurrency(totalInDate),
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: totalInDate < 0 ? AppColors.redColor : AppColors.greenColor),
      ),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listNoteModelCurrent.length,
          itemBuilder: (context, index) {
            NoteModel noteCurrent = listNoteModelCurrent[index]['note'];
            TypeModel typeCurrent = listNoteModelCurrent[index]['type'];
            return ItemNote(
              noteModel: noteCurrent,
              typeModel: typeCurrent,
              isUpdate: false,
            );
          },
        ),
      ],
    );
  }

  int getTotal(List<Map<String, dynamic>> listNoteModelCurrent) {
    int sum = 0;
    for (var element in listNoteModelCurrent) {
      NoteModel noteModel = element['note'];
      TypeModel typeModel = element['type'];

      if (typeModel.groupType == Utils.groupType[0]) {
        sum += noteModel.money!;
      } else {
        sum -= noteModel.money!;
      }
    }
    return sum;
  }
}
