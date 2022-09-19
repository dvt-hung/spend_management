import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_management/utils/app_colors.dart';

class InputComponent extends StatelessWidget {
  InputComponent({
    Key? key,
    this.iconInput,
    this.colorTextInput = Colors.black,
    this.fontWeightTextInput = FontWeight.normal,
    this.fontSizeTextInput = 16.0,
    this.hinText,
    this.colorHintTextInput = Colors.black,
    this.fontWeightHintTextInput = FontWeight.normal,
    this.fontSizeHintTextInput = 16.0,
    this.maxLine = 1,
    this.textInputType = TextInputType.text,
    this.onTap,
    this.readOnly = false,
    this.onChange,
    this.controller,
  }) : super(key: key);

  String? iconInput;
  Color? colorTextInput;
  FontWeight? fontWeightTextInput;
  double? fontSizeTextInput;
  String? hinText;
  Color? colorHintTextInput;
  FontWeight? fontWeightHintTextInput;
  double? fontSizeHintTextInput;
  int? maxLine;
  TextInputType? textInputType;
  Function()? onTap;
  Function(String value)? onChange;
  bool readOnly;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconInput.toString().isEmpty || iconInput == null
            ? const SizedBox(
                height: 40,
                width: 40,
              )
            : CachedNetworkImage(
                imageUrl: iconInput.toString(),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.question_mark),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            onChanged: onChange,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: textInputType,
            maxLines: maxLine,
            style: TextStyle(
              color: colorTextInput,
              fontWeight: fontWeightTextInput,
              fontSize: fontSizeTextInput,
            ),
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.appbarColor),
              ),
              hintText: hinText,
              hintStyle: TextStyle(
                fontSize: fontSizeHintTextInput,
                color: colorHintTextInput,
                fontWeight: fontWeightHintTextInput,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
