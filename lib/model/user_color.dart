import 'dart:ui';

import 'package:flutter/material.dart';

class UserColor {
  UserColor(
      {this.selectColor,
      this.unSelectColor,
      this.quoteColor,
      this.highlightBackgroundColor,
      this.iconColor});

  factory UserColor.auto(BuildContext context) {
    return _isDark(context) ? UserColor.dark() : UserColor.light();
  }

  factory UserColor.light() => UserColor(
      selectColor: COLOR_HOKI,
      unSelectColor: COLOR_MONSOON,
      iconColor: COLOR_DARK_GRAY,
      quoteColor: COLOR_HOKI);

  factory UserColor.dark() => UserColor(
      highlightBackgroundColor: COLOR_HUNTER_GREEN,
      quoteColor: COLOR_HOKI,
      selectColor: COLOR_HOKI,
      iconColor: COLOR_MERCURY,
      unSelectColor: COLOR_MOUNTAIN_MIST);

  Color quoteColor;
  Color selectColor;
  Color unSelectColor;
  Color highlightBackgroundColor;
  Color iconColor;

  static const Color COLOR_CRAIL = Color(0xFFB94C40);
  static const Color COLOR_PINK_LACE = Color(0xFFF7CCD4);
  static const Color COLOR_HOKI = Color(0xFF667C89);
  static const Color COLOR_CLOUD_BURST = Color(0xFF344053);

  static const Color COLOR_ALABASTER = Color(0xFFFCFCFC);
  static const Color COLOR_MERCURY = Color(0xFFE7E5E5);
  static const Color COLOR_LIGHT_GRAY = Color(0xFFD2D1D1);
  static const Color COLOR_PALE_SLATE = Color(0xFFC3C2C2);
  static const Color COLOR_FRENCH_GRAY = Color(0xFFBFBEBE);
  static const Color COLOR_SILVER_CHALICE = Color(0xFFACACAC);
  static const Color COLOR_ALUMINUM = Color(0xFF999999);
  static const Color COLOR_MOUNTAIN_MIST = Color(0xFF959595);
  static const Color COLOR_MONSOON = Color(0xFF787878);
  static const Color COLOR_STORM_DUST = Color(0xFF636363);
  static const Color COLOR_DARK_GRAY = Color(0xFF585858);
  static const Color COLOR_TUATARA = Color(0xFF424344);
  static const Color COLOR_MINE_SHAFT = Color(0xFF323334);
  static const Color COLOR_NERO = Color(0xFF262626);
  static const Color COLOR_HUNTER_GREEN = Color(0xFF171717);
  static const Color COLOR_ONYX = Color(0xFF0E0E0E);
  static const Color COLOR_BLACK = Color(0xFF000000);

  static const Color COLOR_TRANSPARENT_ALABASTER = Color(0xAAFCFCFC);
  static const Color COLOR_TRANSPARENT_BLACK = Color(0x88000000);

  static Color _getColor(BuildContext context, Color light, Color dark) {
    return _isDark(context) ? dark : light;
  }

  static bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
