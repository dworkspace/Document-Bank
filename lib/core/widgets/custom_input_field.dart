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
    this.maxLines = 1,
    this.readOnly = false,
    this.onFieldTap,
  }) : super(key: key);

  final String? hintText;
  final String? titleText;
  final TextInputType? inputType;
  final bool isObSecure;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onFieldTap;

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
            readOnly: readOnly,
            controller: controller,
            obscureText: isObSecure,
            maxLines: maxLines,
            keyboardType: inputType,
            validator: validator,
            onTap: onFieldTap,
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
