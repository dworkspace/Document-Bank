import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import 'custom_input_field.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Image.asset(
            ImageAssets.dbLogoImg,
            height: 40.0,
            width: 40.0,
          ),
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomInputField(
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
            ),
          ))
        ],
      ),
    );
  }
}
