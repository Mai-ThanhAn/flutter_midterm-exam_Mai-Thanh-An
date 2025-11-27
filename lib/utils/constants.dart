// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class AppColors {
  static const Color themePrimary = Color(0xFF7B011E);
  static const Color themeSecondary = Color(0xFFF5F1E6);
  static const Color primaryText = Color(0xFF7B011E);
  static const Color secondaryText = Color(0xFFF5F1E6);

  // Define a set of custom colors to use in the app [Exercise 2]
  static const List<Color> customColors = [
    Color(0xFF510A09),
    Color(0xFF851C15),
    Color(0xFFD83E38),
    Color(0xFFD8A9A0),
    Color(0xFFF79489),
    Color(0xFFFADCD9),
  ];

  static Color getColorByIndex(int index, {double opacity = 1.0}) {
    return customColors[index % customColors.length].withOpacity(opacity);
  }
}
