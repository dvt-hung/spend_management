import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/pages/history/history_controller.dart';
import 'package:spend_management/services/api_services.dart';
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
        body: PageView.builder(
          controller: historyController.pageViewController,
          itemCount: Utils.monthsOfYear.length,
          onPageChanged: (int index) {
            historyController.onChangePage(index);
          },
          itemBuilder: (context, index) {
            return GetBuilder<HistoryController>(
              id: 'updateData',
              builder: (_) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: historyController.listNoteByDateOfMonth.length,
                    itemBuilder: (context, index) {
                      // Get list noteModel by index
                      List<NoteModel> listNoteModelCurrent =
                          historyController.listNoteByDateOfMonth[index];
                      // List<Map<String, dynamic>> listNoteModelCurrent =
                      //     historyController.listNoteByDateOfMonth2[index];

                      // Get time display title
                      DateTime time = listNoteModelCurrent[0].date!.toDate();

                      return Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.whiteColor,
                        ),
                        child: ExpansionTile(
                          title: Text(Utils.formatFullDate.format(time)),
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listNoteModelCurrent.length,
                              itemBuilder: (context, index) {
                                NoteModel noteCurrent =
                                    listNoteModelCurrent[index];
                                return FutureBuilder(
                                  future: ApiServices.getSingleType(
                                      noteCurrent.type.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      TypeModel type =
                                          snapshot.data as TypeModel;

                                      return ItemNote(
                                          noteModel: noteCurrent,
                                          typeModel: type);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: GetBuilder<HistoryController>(
        id: 'updateView',
        builder: (_) {
          return ScrollablePositionedList.builder(
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
}
