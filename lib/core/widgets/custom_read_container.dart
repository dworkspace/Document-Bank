import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class CustomReadContainer extends StatelessWidget {
  const CustomReadContainer({
    Key? key,
    required this.textValue,
    this.titleText,
    this.suffixIcon,
    this.isHint = true,
    this.onTap,
  }) : super(key: key);

  final String textValue;
  final String? titleText;
  final Widget? suffixIcon;
  final bool isHint;
  final VoidCallback? onTap;

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
        GestureDetector(
          onTap: onTap,
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: ColorManager.grayColor.withOpacity(0.8),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      textValue,
                      style: getRegularStyle(
                        color: isHint
                            ? ColorManager.gray
                            : ColorManager.blackColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: suffixIcon ?? Container(),
                  )
                ],
              )),
        )
      ],
    );
  }
}
