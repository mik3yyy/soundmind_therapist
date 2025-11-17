import 'package:flutter/material.dart';
import 'package:soundmind_therapist/core/theme/theme.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  // Access the screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  // Access the primary color from the theme
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  // Access the text theme
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppColorExtension get colors => Theme.of(this).extension<AppColorExtension>()!;

  // Show a snackbar
  // void showSnackBar(String message) {
  //   ScaffoldMessenger.of(this).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         message,
  //         style: TextStyle(color: colors.white),
  //       ),
  //       backgroundColor: primaryColor,
  //     ),
  //   );
  // }
  void showSnackBar(String message) {
    showTopSnackBar(
      Overlay.of(this),
      CustomSnackBar.info(
        message: message, //"Something went wrong. Please check your credentials and try again",
        backgroundColor: primaryColor,
      ),
    );
  }
}
