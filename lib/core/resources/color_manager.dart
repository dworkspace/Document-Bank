import 'package:flutter/rendering.dart';

class ColorManager {
  static Color primaryYellow = HexColor.fromHex("#FFC000");
  static Color primaryOpacity70 = HexColor.fromHex("#B3FFC000");
  static Color blackColor = HexColor.fromHex("#000000");
  static Color grayColor = HexColor.fromHex("#959595");
  static Color whiteColor = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#E61F34");
  static Color gray = HexColor.fromHex("#BEBEBF");
  static Color darkBlue = HexColor.fromHex("#011F5F");
  static Color primaryBloodColor = HexColor.fromHex("#993E15");
  static Color purple = HexColor.fromHex('#5D2DFF');
  static Color redColor = HexColor.fromHex("#F83F3F");
  static Color greenColor = HexColor.fromHex("#14BC52");
  static Color pinkColor = HexColor.fromHex("#F22DDE");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; //8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
