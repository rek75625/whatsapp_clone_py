import 'package:flutter/material.dart';

/// A centralized class for your app's design system constants.
/// Use this to ensure consistent fonts, text styles, and colors across the app.
class DefaultColors {
  static const Color greyText = Color(0xFFB3B9C9);
  static const Color whiteText = Color(0xFFFFFFFF);
  static const Color senderMessage = Color(0xFF7A8194);
  static const Color receiverMessage = Color(0xFF373E4E);
  static const Color sentMessageInput = Color(0xFF3D4354);
  static const Color messageListPage = Color(0xFF292F3F);
  static const Color buttonColor = Color(0xFF7A8194);
}

class DoubleShade {
  final Color lightShade;
  final Color darkShade;

  DoubleShade(this.lightShade, this.darkShade);
}

class AppColors {
  // Prevent instantiation
  AppColors._();

  // ==========================================
  //                FONTS
  // ==========================================
  static const String sFPro = 'SF Pro Text';

  // Text Styles configured with SF Pro weights
  static const TextStyle sFProRegular = TextStyle(
    fontFamily: sFPro,
    fontWeight: FontWeight.w400, // Regular
  );

  static const TextStyle sFProMedium = TextStyle(
    fontFamily: sFPro,
    fontWeight: FontWeight.w500, // Medium
  );

  static const TextStyle sFProBold = TextStyle(
    fontFamily: sFPro,
    fontWeight: FontWeight.w700, // Bold
  );

  // ==========================================
  //            PRIMARY COLORS
  // ==========================================
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color greenColor = Color(0xFF5CE27F);
  static const Color yellowColor = Color(0xFFFFE12D);
  static const Color redColor = Color(0xFFE25C5C);
  static const Color primaryBlue = Color(0xFF5CABE2);
  static const Color primaryBlack = Color(0xFF000000);

  // Gradient helper based on the design
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [greenColor, primaryBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // ==========================================
  //        SYSTEM COLORS & GREYSCALE
  // ==========================================
  static const Color darkGrey1 = Color(0xFF121212);
  static const Color darkGrey2 = Color(0xFF313131);
  static const Color lightGrey = Color(0xFFB1B1B1);
}

extension DarkMode on BuildContext {
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}

Color backgroundColor(BuildContext context, {bool invert = false}) =>
    (invert ? !context.isDarkMode : context.isDarkMode)
    ? Colors.black87
    : AppColors.backgroundColor;

DoubleShade blackColor(BuildContext context) => context.isDarkMode
    ? DoubleShade(AppColors.lightGrey, AppColors.backgroundColor)
    : DoubleShade(Color(0xFF313131), Color(0xFF121212));

DoubleShade blackColors = DoubleShade(Color(0xFF313131), Color(0xFF121212));
DoubleShade greenGradient = DoubleShade(Color(0xFF5CE27F), Color(0xFF5CABE2));
DoubleShade grayColors = DoubleShade(Color(0xFFB1B1B1), Color(0xFFEFEFEF));
