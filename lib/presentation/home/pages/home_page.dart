import 'package:document_bank/core/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/router/routes_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        _topBar(),
        _chooseServiceSection(),
        _allRemindersSection(),
        _recentSection(),
      ],
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomInputField(
              hintText: "Type what you searching for...",
              suffixIcon: Icon(Icons.search),
            ),
          )),
          Image.asset(
            ImageAssets.dbLogoImg,
            height: 40.0,
            width: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _chooseServiceSection() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
        const SizedBox(height: 18.0),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          children: [
            _gridviewItem(
              title: "Capture & Archive",
              imageURL: IconAssets.cameraAltImg,
              onTap: () =>
                  Navigator.pushNamed(context, Routes.addDocumentsRoute),
            ),
            _gridviewItem(
              title: "Scan  & Archive",
              imageURL: IconAssets.scanImg,
            ),
            _gridviewItem(
              title: "U & ME Chat",
              imageURL: IconAssets.chatImg,
            ),
            _gridviewItem(
              title: "Work \nTODO",
              imageURL: IconAssets.notesImg,
              onTap: () => Navigator.pushNamed(context, Routes.goalsRoute),
            ),
            _gridviewItem(
              title: "Important Memo",
              imageURL: IconAssets.userMenu,
            ),
            _gridviewItem(
              title: "Auto Save Contact",
              imageURL: IconAssets.autoSaveImg,
              onTap: () => Navigator.pushNamed(context, Routes.contactsRoute),
            ),
          ],
        ),
        // const SizedBox(height: AppSize.s24),
        // _serviceWidget(
        //   title: "Only UME Chat",
        //   iconPath: IconAssets.chatImg,
        //   bgColor: ColorManager.primaryYellow,
        // ),
        // const SizedBox(height: AppSize.s20),
        // _serviceWidget(
        //   title: "Scan & Archive IMP Documents",
        //   iconPath: IconAssets.cameraImg,
        //   bgColor: ColorManager.purple,
        //   onTap: () => Navigator.pushNamed(context, Routes.addDocumentsRoute),
        // ),
        // const SizedBox(height: AppSize.s20),
        // _serviceWidget(
        //   title: "Important Memo",
        //   iconPath: IconAssets.memoImg,
        //   bgColor: ColorManager.redColor,
        // ),
        // const SizedBox(height: AppSize.s20),
        // _serviceWidget(
        //     title: "Autosave Your Contacts",
        //     iconPath: IconAssets.contactImg,
        //     bgColor: ColorManager.greenColor,
        //     onTap: () => Navigator.pushNamed(context, Routes.contactsRoute)),
        // const SizedBox(height: AppSize.s20),
        // _serviceWidget(
        //   title: "Work to do in my life #10",
        //   iconPath: IconAssets.notesImg,
        //   bgColor: ColorManager.pinkColor,
        //   onTap: () => Navigator.pushNamed(context, Routes.goalsRoute),
        // ),
      ],
    );
  }

  Widget _allRemindersSection() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Routes.myRemindersRoute);
      },
      child: Container(
        color: ColorManager.darkBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Image.asset(
              IconAssets.reminderWatchImg,
              color: ColorManager.whiteColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "All Reminders",
                  style: getSemiBoldStyle(
                    color: ColorManager.whiteColor,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Image.asset(
                IconAssets.arrowRightImg,
                color: ColorManager.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridviewItem({
    required String title,
    required String imageURL,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageURL,
            height: 40.0,
            width: 40.0,
            color: ColorManager.blackColor,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: 18.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _recentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: const [
          //       Expanded(child: DocFolder()),
          //       SizedBox(width: 16.0),
          //       Expanded(child: DocFolder())
          //     ],
          //   ),
          // )
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
