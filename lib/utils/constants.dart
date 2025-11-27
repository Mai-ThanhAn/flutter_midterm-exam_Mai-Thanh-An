// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class AppColors {
  static const Color themePrimary = Color(0xFF7B011E);
  static const Color themeSecondary = Color(0xFFF5F1E6);
  static const Color primaryText = Color(0xFF7B011E);
  static const Color secondaryText = Color(0xFFF5F1E6);

  // Creat MaterialColor from themePrimary
  Map<int, Color> colorShades = {
    50: themePrimary.withOpacity(0.1),
    100: themePrimary.withOpacity(0.2),
    200: themePrimary.withOpacity(0.3),
    300: themePrimary.withOpacity(0.4),
    400: themePrimary.withOpacity(0.5),
    500: themePrimary.withOpacity(0.6),
    600: themePrimary.withOpacity(0.7),
    700: themePrimary.withOpacity(0.8),
    800: themePrimary.withOpacity(0.9),
    900: themePrimary.withOpacity(1.0),
  };

}
