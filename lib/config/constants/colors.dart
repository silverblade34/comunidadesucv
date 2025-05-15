import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff9852F6);
  static const Color secondary = Color(0xffFFB200);
  static const Color backgroundLight = Color(0xffF5F4FF);
  static const Color backgroundDark = Color(0xff220C61);
  static const Color backgroundDarkIntense = Color(0xff0E0847);
  static const Color backgroundDarkLigth = Color.fromARGB(128, 149, 117, 205);
  static const Color textBlackUCV = Color(0xFF0E0847);
  static const Color backgroundDialogDark = Color.fromARGB(255, 9, 3, 55);
  static const Color textLight = Color(0xff120C45);
  static const Color textDarkTitle = Color(0xffE5E3FC);
  static const Color textDarkSubtitle = Color(0xff9790CC);
  static const Color textDark = Colors.white;
  static const Color iconLight = Color(0xff2b2b2b);
  static const Color iconDark = Colors.white;

  // ignore: deprecated_member_use
  static Color shimmerBaseColor = Colors.grey.withOpacity(0.3);
  // ignore: deprecated_member_use
  static Color shimmerHighlightColor = Colors.grey.withOpacity(0.2);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
