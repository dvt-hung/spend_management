import 'package:get/get.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/utils.dart';

class HomeController extends GetxController {
  // <----------------- Variable ---------------->

  List<Map<String, dynamic>> mapNoteIncome = [];
  List<Map<String, dynamic>> mapNoteSpending = [];

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

  getNoteToday() async {
    await ApiServices.getNoteToday((event) async {
      List<dynamic> result = event;
      // <-- Clear variable money + list -->
      spendingMoney = 0;
      incomeMoney = 0;

      // <-- Loop data from db -->
      for (var data in result) {
        mapNoteIncome.clear();
        mapNoteSpending.clear();
        NoteModel note = NoteModel.fromJon(data);
        // <--- Get type by note.idType --->
        await ApiServices.getSingleType(
          note.type.toString(),
          (dateType) async {
            TypeModel typeModel = TypeModel.fromJson(dateType);
            // <--- If type = "khoản thu" --->
            if (typeModel.groupType == Utils.groupType[0]) {
              mapNoteIncome.add({"note": note, "type": typeModel});
              incomeMoney = await plusMoney(incomeMoney, note.money!);
            }
            // <--- If type = "chi tiêu" --->
            else {
              mapNoteSpending.add({"note": note, "type": typeModel});
              spendingMoney = await plusMoney(spendingMoney, note.money!);
            }

            // Update GetX
            update(['getToday']);
          },
        );
      }
    });
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
    getTotalMoney();
    await getNoteToday();
  }
}
