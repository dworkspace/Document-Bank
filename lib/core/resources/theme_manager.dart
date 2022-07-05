import 'package:document_bank/core/resources/font_manager.dart';
import 'package:document_bank/core/resources/styles_manager.dart';
import 'package:document_bank/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors of the app
    primaryColor: ColorManager.primaryYellow,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grayColor, // usecase eg. disabled button
    //ripple color
    splashColor: ColorManager.primaryOpacity70,
    fontFamily: FontConstants.fontFamily,
    scaffoldBackgroundColor: ColorManager.whiteColor,

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.blackColor,
    ),

    //appbar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.primaryOpacity70,
      elevation: 0,
      iconTheme: IconThemeData(
        color: ColorManager.blackColor,
      ),
      titleTextStyle: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
    ),
    //bottomAppbarTheme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.whiteColor,
      selectedItemColor: ColorManager.blackColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorManager.grayColor,
      showUnselectedLabels: true,
      selectedLabelStyle: getMediumStyle(
        color: ColorManager.gray,
      ),
      unselectedLabelStyle: getRegularStyle(
        color: ColorManager.gray,
      ),
      selectedIconTheme: IconThemeData(
        color: ColorManager.blackColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: ColorManager.grayColor,
      ),
    ),

    //elevated theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
        textStyle: getMediumStyle(
          color: ColorManager.whiteColor,
          fontSize: FontSize.s16,
        ),
        elevation: 0,
        primary: ColorManager.primaryYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s4),
        ),
      ),
    ),

    //input decoration
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSize.s8),
      hintStyle: getRegularStyle(color: ColorManager.gray),
      labelStyle: getMediumStyle(color: ColorManager.gray),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.gray, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
      // focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.gray, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
      // error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),

      // error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primaryYellow, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s4),
      ),
    ),
  );

  // //app bar theme
  // appBarTheme: AppBarTheme(
  //   centerTitle: true,
  //   color: ColorManager.primary,
  //   shadowColor: ColorManager.primaryOpacity70,
  //   elevation: AppSize.s4,
  //   titleTextStyle: getRegularStyle(
  //     color: ColorManager.white,
  //     fontSize: FontSize.s16,
  //   ),
  // ),

  //   //button theme
  //   buttonTheme: ButtonThemeData(
  //     shape: const StadiumBorder(),
  //     disabledColor: ColorManager.grey1,
  //     buttonColor: ColorManager.primary,
  //     splashColor: ColorManager.primaryOpacity70,
  //   ),
  //   //elevated button theme
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     textStyle: getRegularStyle(color: ColorManager.white),
  //     primary: ColorManager.primary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(AppSize.s12),
  //     ),
  //   ),
  // ),

  //   //text theme
  //   textTheme: TextTheme(
  //     headline1: getSemiBoldStyle(
  //         color: ColorManager.darkGrey, fontSize: FontSize.s16),
  //     headline2:
  //         getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
  //     headline3:
  //         getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s16),
  //     headline4:
  //         getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s14),
  //     subtitle1:
  //         getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
  //     subtitle2:
  //         getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s12),
  //     caption: getRegularStyle(color: ColorManager.grey1),
  //     bodyText1: getRegularStyle(color: ColorManager.grey),
  //     bodyText2:
  //         getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
  //   ),

  //   //input decoration theme
  //   inputDecorationTheme: InputDecorationTheme(
  //     contentPadding: const EdgeInsets.all(AppSize.s8),
  //     hintStyle: getRegularStyle(color: ColorManager.grey1),
  //     labelStyle: getMediumStyle(color: ColorManager.darkGrey),
  //     errorStyle: getRegularStyle(color: ColorManager.error),

  //     // enabled border
  //     enabledBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1),
  //       borderRadius: BorderRadius.circular(AppSize.s8),
  //     ),
  //     // focused border
  //     focusedBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1),
  //       borderRadius: BorderRadius.circular(AppSize.s8),
  //     ),
  //     // error border
  //     errorBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
  //       borderRadius: BorderRadius.circular(AppSize.s8),
  //     ),

  //     // error border
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1),
  //       borderRadius: BorderRadius.circular(AppSize.s8),
  //     ),
  //   ),
  // );
}
