import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/utils.dart';

class HomeController extends GetxController {
  // <----------------- Variable ---------------->

  List<Map<String, dynamic>> mapNoteIncome = [];
  List<Map<String, dynamic>> mapNoteSpending = [];

  final id_Income = Set();
  final id_Spend = Set();

  int spendingMoney = 0;
  int incomeMoney = 0;

  // <----------------- Function ---------------->
  getTotalMoney() async {
    await ApiServices.getTotalMoney(
      (data) {
        Utils.totalMoney = data['total'];
        update(['totalMoney']);
      },
    );
  }

  Future getNotes() async {
    ApiServices.getNoteToday(
      (event) async {
        List<dynamic> result = event;
        await processData(result);
      },
    );
  }

  Future processData(List<dynamic> result) async {
    // <-- Clear variable money + list -->
    incomeMoney = 0;
    spendingMoney = 0;
    mapNoteIncome.clear();
    mapNoteSpending.clear();
    // <-- Loop data from db -->
    for (var i = 0; i < result.length; i++) {
      NoteModel note = NoteModel.fromJson(result[i]);

      TypeModel typeModel =
          await ApiServices.getSingleType(note.type.toString());

      if (typeModel.groupType == Utils.groupType[0]) {
        mapNoteIncome.add({"note": note, "type": typeModel});
        incomeMoney = await plusMoney(incomeMoney, note.money!);
      }
      // // <--- If type = "chi tiêu" --->
      else {
        mapNoteSpending.add({"note": note, "type": typeModel});
        spendingMoney = await plusMoney(spendingMoney, note.money!);
      }
      update(['getToday']);
    }
  }

  // <----- update money: spending or income ---->
  Future<int> plusMoney(int root, int money) async {
    root += money;
    return root;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getTotalMoney();
    await getNotes();
  }
}
