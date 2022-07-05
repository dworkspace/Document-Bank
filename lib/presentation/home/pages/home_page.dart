import 'package:document_bank/core/router/routes_manager.dart';
import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:document_bank/core/widgets/doc_folder.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          _topBar(),
          _chooseServiceSection(),
          _recentSection(),
        ],
      ),
    );
  }

  Widget _topBar() {
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

  Widget _chooseServiceSection() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text(
          "Choose Service",
          style: getMediumStyle(
            color: ColorManager.blackColor,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: AppSize.s24),
        _serviceWidget(
          title: "Only UME Chat",
          iconPath: IconAssets.chatImg,
          bgColor: ColorManager.primaryYellow,
        ),
        const SizedBox(height: AppSize.s20),
        _serviceWidget(
          title: "Scan & Archive IMP Documents",
          iconPath: IconAssets.cameraImg,
          bgColor: ColorManager.purple,
          onTap: () => Navigator.pushNamed(context, Routes.addDocumentsRoute),
        ),
        const SizedBox(height: AppSize.s20),
        _serviceWidget(
          title: "Important Memo",
          iconPath: IconAssets.memoImg,
          bgColor: ColorManager.redColor,
        ),
        const SizedBox(height: AppSize.s20),
        _serviceWidget(
            title: "Autosave Your Contacts",
            iconPath: IconAssets.contactImg,
            bgColor: ColorManager.greenColor,
            onTap: () => Navigator.pushNamed(context, Routes.contactsRoute)),
        const SizedBox(height: AppSize.s20),
        _serviceWidget(
          title: "Work to do in my life #10",
          iconPath: IconAssets.notesImg,
          bgColor: ColorManager.pinkColor,
          onTap: () => Navigator.pushNamed(context, Routes.goalsRoute),
        ),
      ],
    );
  }

  Widget _recentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent",
                style: getMediumStyle(
                  color: ColorManager.blackColor,
                  fontSize: FontSize.s16,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Add New",
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                    ),
                  ),
                  Image.asset(
                    IconAssets.noteAddImg,
                    color: ColorManager.blackColor,
                    height: 24.0,
                    width: 24.0,
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(child: DocFolder()),
                SizedBox(width: 16.0),
                Expanded(child: DocFolder())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _serviceWidget({
    required String title,
    required String iconPath,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.grayColor.withOpacity(0.3),
                  offset: const Offset(0, 0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                )
              ],
            ),
            child: Image.asset(
              iconPath,
              height: AppSize.s24,
              width: AppSize.s24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 4.0, bottom: 4.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Divider(color: ColorManager.blackColor),
                ],
              ),
            ),
          ),
          Image.asset(
            IconAssets.rightArrowImg,
            height: AppSize.s24,
            width: AppSize.s24,
            color: ColorManager.blackColor,
          )
        ],
      ),
    );
  }
}
