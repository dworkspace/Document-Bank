import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class DocFolder extends StatelessWidget {
  const DocFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.asset(
              "assets/images/citizenship_front.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100.0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.darkBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            alignment: Alignment.center,
            child: Text(
              "My Citizenships",
              style: getRegularStyle(
                color: ColorManager.whiteColor,
                fontSize: 14.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
