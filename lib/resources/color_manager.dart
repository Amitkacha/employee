import 'package:flutter/material.dart';

class ColorManager {
  static Color transparent = Colors.transparent;
  static Color primary = HexColor.fromHex("#1DA1F2");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color black = HexColor.fromHex("#000000");
  static Color color0E8AD7 = HexColor.fromHex("#0E8AD7");
  static Color color323238 = HexColor.fromHex("#323238");
  static Color colorE5E5E5 = HexColor.fromHex("#E5E5E5");
  static Color color949C9E = HexColor.fromHex("#949C9E");
  static Color colorF2F2F2 = HexColor.fromHex("#F2F2F2");
  static Color colorEDF8FF = HexColor.fromHex("#EDF8FF");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
