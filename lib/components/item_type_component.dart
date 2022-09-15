import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/pages/types/type_controller.dart';

import '../models/type_model.dart';
import '../pages/add_spending/add_spending_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ItemType extends StatelessWidget {
  const ItemType({
    Key? key,
    required this.typeModel,
  }) : super(key: key);

  final TypeModel typeModel;

  @override
  Widget build(BuildContext context) {
    final addSpendingController = Get.find<AddSpendingController>();
    final typeController = Get.find<TypeController>();

    return Column(
      children: [
        ListTile(
          onTap: () {
            addSpendingController.changeType(typeModel);
            Get.back();
          },
          leading: CachedNetworkImage(
            imageUrl: typeModel.urlType.toString(),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const Icon(Icons.question_mark),
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          title: Text(
            typeModel.contentType.toString(),
            style: AppStyles.textStyle.copyWith(fontSize: 14),
          ),
          trailing: GetBuilder<TypeController>(
              id: 'actionUpdate',
              builder: (_) {
                return typeController.isUpdate
                    ? IconButton(
                        onPressed: () {
                          typeController.showDialogUpdateType(typeModel);
                        },
                        icon: const Icon(
                          Icons.restart_alt,
                          color: Colors.black,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
        ),
        const Divider(
          height: 10,
          indent: 30,
          endIndent: 30,
          color: AppColors.backgroundColor,
        )
      ],
    );
  }
}
