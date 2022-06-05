import 'package:document_bank/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    this.hintText,
    this.titleText,
    this.inputType = TextInputType.text,
    this.isObSecure = false,
    this.validator,
    this.suffixIcon,
    this.autoValidateMode,
    this.controller,
  }) : super(key: key);

  final String? hintText;
  final String? titleText;
  final TextInputType? inputType;
  final bool isObSecure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: titleText != null,
          child: Text(
            titleText ?? "",
            style: getMediumStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: TextFormField(
            controller: controller,
            obscureText: isObSecure,
            keyboardType: inputType,
            validator: validator,
            autovalidateMode: autoValidateMode,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              suffixIcon: suffixIcon,
            ),
          ),
        )
      ],
    );
  }
}
