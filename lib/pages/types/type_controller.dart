import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_management/pages/add_spending/spending_controller.dart';
import 'package:spend_management/pages/types/types_page.dart';
import 'package:spend_management/services/api_services.dart';
import 'package:spend_management/utils/app_colors.dart';
import 'package:spend_management/utils/app_dialogs.dart';
import 'package:spend_management/utils/app_styles.dart';
import 'package:spend_management/utils/utils.dart';

import '../../models/type_model.dart';

class TypeController extends GetxController {
  // <-------------- Variable --------------->
  File? fileImageType;
  TextEditingController contentTypeController = TextEditingController();
  String msg = "";
  bool enableMsg = false;
  bool isUpdate = false;
  List<TypeModel> listTypeModelsIncome = [];
  List<TypeModel> listTypeModelsSpending = [];
  String valueGroupType = Utils.groupType[0];

  // <-------------- Function --------------->
  void changeActionUpdate() {
    isUpdate = !isUpdate;
    update(['actionUpdate']);
  }

  @override
  void onInit() async {
    super.onInit();
    await getTypes();
  }

  // <----- Get list types ---->
  Future getTypes() async {
    await ApiServices.getListTypes((types) {
      List<dynamic> list = types;
      listTypeModelsIncome.clear();
      listTypeModelsSpending.clear();
      for (var data in list) {
        TypeModel model = TypeModel.fromJson(data);
        if (model.groupType.toString() == Utils.groupType[0].toString()) {
          listTypeModelsIncome.add(model);
        } else {
          listTypeModelsSpending.add(model);
        }
      }
      update(['getTypes']);
    });
  }

  // <----- Pick image ---->
  Future pickerImage() async {
    fileImageType = await Utils.pickerImage();
    update(['pickerImage']);
  }

  // <----- Add types ----->
  Future addNewType() async {
    TypeModel typeModel = TypeModel();
    String content = contentTypeController.text;
    typeModel.groupType = valueGroupType;
    // Check value
    if (fileImageType == null || content.isEmpty) {
      msg = "??ang b??? tr???ng d??? li???u k??a!";
      enableMsg = true;
    } else {
      // Show dialogProgress
      Get.dialog(AppDialogs.alertDialogProgress);

      // set content value -> model
      typeModel.contentType = content;

      // Call API
      ApiServices.insertType(
        typeModel,
        fileImageType,
        (result) {
          if (result) {
            Get.back();
            AppDialogs.showSnackBar(
              "Th??ng b??o",
              "???? th??m m???i th??nh c??ng",
            );

            fileImageType = null;
            contentTypeController.clear();
            valueGroupType = Utils.groupType[0];
          } else {
            msg = "???? c?? l???i x???y ra!";
            Get.back();
          }
        },
      );
    }
    update(['updateMessage']);
  }

  void changeGroup(String val) {
    valueGroupType = val;
    update(['updateGroupType']);
  }

  // <----- Show dialog add new type ----->
  showDialogAddType() async {
    Get.defaultDialog(
      radius: 10.0,
      title: "Th??m m???i",
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: const EdgeInsets.all(5.0),
      content: Column(
        children: [
          // <----- ???NH C???A DIALOG ----->
          GetBuilder<TypeController>(
            id: 'pickerImage',
            builder: (_) {
              return GestureDetector(
                  onTap: pickerImage,
                  child: fileImageType == null
                      ? Image.asset(
                          "assets/gallery.png",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          fileImageType!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ));
            },
          ),
          const SizedBox(
            height: 5.0,
          ),
          // <----- NH???P T??N NH??M CHI TI??U C???A DIALOG ----->
          TextFormField(
            controller: contentTypeController,
            decoration: InputDecoration(
              hintText: "T??n nh??m chi ti??u ",
              label: const Text("T??n chi ti??u"),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),

          GetBuilder<TypeController>(
            id: 'updateMessage',
            builder: (_) {
              return enableMsg ? Text(msg) : const SizedBox.shrink();
            },
          ),

          // <----- L???A CH???N KHO???N THU HAY CHI TI??U ----->

          GetBuilder<TypeController>(
              id: 'updateGroupType',
              builder: (_) {
                return Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                          dense: true,
                          title: Text(
                            Utils.groupType[0],
                          ),
                          value: Utils.groupType[0],
                          groupValue: valueGroupType,
                          onChanged: (val) {
                            changeGroup(val.toString());
                          }),
                    ),
                    Expanded(
                      child: RadioListTile<dynamic>(
                        dense: true,
                        title: Text(Utils.groupType[1]),
                        value: Utils.groupType[1],
                        groupValue: valueGroupType,
                        onChanged: (val) {
                          changeGroup(val.toString());
                        },
                      ),
                    ),
                  ],
                );
              }),

          // <----- N??T THAO T??C C???A DIALOG ----->
          Row(
            children: [
              TextButton(
                onPressed: () {
                  fileImageType = null;
                  contentTypeController.clear();
                  Get.back();
                },
                child: const Text(
                  "H???y",
                  style: TextStyle(fontSize: 16, color: AppColors.thirdColor),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              TextButton(
                onPressed: () {
                  addNewType();
                },
                child: const Text(
                  "X??c nh???n",
                  style: TextStyle(fontSize: 16, color: AppColors.selectColor),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }

  // <----- Add types ----->
  Future updateType(TypeModel typeModel) async {
    String content = contentTypeController.text;

    // Check value
    if (content.isEmpty) {
      msg = "??ang b??? tr???ng d??? li???u k??a!";
      enableMsg = true;
    } else {
      // Show dialogProgress
      Get.dialog(AppDialogs.alertDialogProgress);

      // set content value -> model
      typeModel.contentType = content;

      await ApiServices.updateType(
        typeModel,
        fileImageType,
        (resultUpdate) {
          Get.back();
          if (resultUpdate) {
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.back();

              AppDialogs.showSnackBar(
                "Th??ng b??o",
                "???? c???p nh???t th??nh c??ng",
              );
            });
            fileImageType = null;
            contentTypeController.clear();
          } else {
            msg = "???? c?? l???i x???y ra!";
          }
        },
      );
    }
    update(['updateMessage']);
  }

  // <----- Show dialog add new type ----->
  showDialogUpdateType(TypeModel typeModel) async {
    contentTypeController.text = typeModel.contentType.toString();
    Get.defaultDialog(
      radius: 10.0,
      title: "C???p nh???t",
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: const EdgeInsets.all(5.0),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            // <----- ???NH C???A DIALOG ----->
            GetBuilder<TypeController>(
                id: 'pickerImage',
                builder: (_) {
                  return GestureDetector(
                      onTap: pickerImage,
                      child: fileImageType == null
                          ? CachedNetworkImage(
                              imageUrl: typeModel.urlType.toString(),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.question_mark),
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              fileImageType!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ));
                }),
            const SizedBox(
              height: 10.0,
            ),

            // <----- NH???P T??N NH??M CHI TI??U C???A DIALOG ----->
            TextFormField(
              controller: contentTypeController,
              decoration: InputDecoration(
                hintText: "T??n nh??m chi ti??u ",
                label: const Text("T??n chi ti??u"),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            GetBuilder<TypeController>(
              id: 'updateMessage',
              builder: (_) {
                return enableMsg ? Text(msg) : const SizedBox.shrink();
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            // <----- N??T THAO T??C C???A DIALOG ----->
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    fileImageType = null;
                    contentTypeController.clear();
                    Get.back();
                  },
                  child: const Text("H???y"),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateType(typeModel);
                  },
                  child: const Text("X??c nh???n"),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}
