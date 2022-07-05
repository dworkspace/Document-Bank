import 'package:document_bank/core/resources/assets_manager.dart';
import 'package:document_bank/core/resources/color_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: getMediumStyle(color: ColorManager.blackColor, fontSize: 18.0),
        ),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: ColorManager.darkBlue,
                ),
                Positioned(
                  bottom: 8.0,
                  right: 2.0,
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorManager.grayColor)),
                    child: Image.asset(
                      IconAssets.cameraImg,
                      height: 16.0,
                      width: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "Shree Hari Yadav",
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: 18.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: CustomInputField(
              hintText: "Shree Hari Yadav",
            ),
          )
        ],
      ),
    );
  }
}
