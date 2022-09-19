import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/models/note_model.dart';
import 'package:spend_management/models/type_model.dart';
import 'package:spend_management/pages/add_spending/spending_controller.dart';
import 'package:spend_management/pages/add_spending/spending_page.dart';
import '../utils/app_styles.dart';
import '../utils/utils.dart';

class ItemNote extends StatelessWidget {
  const ItemNote({
    Key? key,
    required this.noteModel,
    required this.typeModel,
  }) : super(key: key);

  final NoteModel noteModel;
  final TypeModel typeModel;
  @override
  Widget build(BuildContext context) {
    SpendingController addSpendingController = Get.put(SpendingController());
    return ListTile(
      onTap: () {
        addSpendingController.type = typeModel;
        addSpendingController.noteModel = noteModel;

        Get.to(
          () => SpendingPage(
            isDetail: true,
            titleAppBar: "Chỉnh sửa giao dịch",
          ),
        );
      },
      leading: CachedNetworkImage(
        imageUrl: typeModel.urlType.toString(),
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => const Icon(Icons.question_mark),
        height: 30,
        width: 30,
        fit: BoxFit.cover,
      ),
      title: Text(
        typeModel.contentType.toString(),
        style: AppStyles.textStyle,
      ),
      trailing: Text(
        Utils.convertCurrency(noteModel.money!),
        style:
            // Nếu là khoản thu thì text color = green. Ngược lại text color = red
            typeModel.groupType == Utils.groupType[0]
                ? AppStyles.priceStyleIncome15
                : AppStyles.priceStyleSpending15,
      ),
    );
  }
}
