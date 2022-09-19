import 'package:flutter/material.dart';
import 'package:spend_management/components/item_type_component.dart';

import '../models/type_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class GroupTypeComponent extends StatelessWidget {
  GroupTypeComponent({Key? key, required this.title, required this.listModel})
      : super(key: key);

  String title;
  List<TypeModel> listModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.titleStyle.copyWith(fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            color: AppColors.whiteColor,
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: listModel.length,
              itemBuilder: (context, index) {
                return ItemType(typeModel: listModel[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
