import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../models/type_model.dart';
import '../utils/app_styles.dart';
import '../utils/utils.dart';
import 'item_note_component.dart';

class NoteBlock extends StatelessWidget {
  const NoteBlock({
    Key? key,
    required this.listItem,
    required this.money,
    required this.title,
    required this.styleMoney,
  }) : super(key: key);

  final List<Map<String, dynamic>> listItem;
  final int money;
  final String title;
  final TextStyle styleMoney;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.textStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                Utils.convertCurrency(money),
                style: styleMoney,
              )
            ],
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            height: 20,
            // color: Colors.amber,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listItem.length,
              itemBuilder: (context, index) {
                // Get note model
                NoteModel noteModel = listItem[index]['note'];

                // Get type model
                TypeModel typeModel = listItem[index]['type'];
                return ItemNote(
                  noteModel: noteModel,
                  typeModel: typeModel,
                  isUpdate: true,
                );
              }),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
