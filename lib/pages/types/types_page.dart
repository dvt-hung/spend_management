import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spend_management/pages/types/type_controller.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:get/get.dart';

import '../../components/item_type_component.dart';
import '../../utils/app_styles.dart';

class TypesPage extends StatelessWidget {
  TypesPage({Key? key}) : super(key: key);

  final TypeController typeController = Get.put(TypeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.appbarColor,
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
      ),
      body: GetBuilder<TypeController>(
        id: 'getTypes',
        builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: typeController.listTypeModels.length,
            itemBuilder: (context, index) {
              return ItemType(typeModel: typeController.listTypeModels[index]);
            },
          );
        },
      ),
    );
  }
}
