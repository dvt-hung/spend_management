import 'package:flutter/material.dart';
import 'package:spend_management/components/group_type_component.dart';
import 'package:spend_management/pages/types/type_controller.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:spend_management/utils/utils.dart';

class TypesPage extends StatelessWidget {
  TypesPage({Key? key}) : super(key: key);

  final TypeController typeController = Get.put(TypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: buildAppBar(),
      body: GetBuilder<TypeController>(
        id: 'getTypes',
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GroupTypeComponent(
                    title: Utils.groupType[0],
                    listModel: typeController.listTypeModelsIncome),
                GroupTypeComponent(
                    title: Utils.groupType[1],
                    listModel: typeController.listTypeModelsSpending),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        GetBuilder<TypeController>(
            id: 'actionUpdate',
            builder: (_) {
              return IconButton(
                onPressed: () {
                  typeController.changeActionUpdate();
                },
                icon: typeController.isUpdate
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.restart_alt),
              );
            }),
        IconButton(
          onPressed: typeController.showDialogAddType,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
