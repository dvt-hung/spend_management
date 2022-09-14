import 'package:get/get.dart';
import 'package:spend_management/models/type_model.dart';

class AddSpendingController extends GetxController {
  TypeModel type = TypeModel();

  void changeType(TypeModel typeModel) {
    type = typeModel;
    update(['updateType']);
  }
}
