import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/utils/SnoseySizes.dart';

class SnoseyButtonThemes {
  static final double _maxButtonHeight = 40.0;
  static final double _maxButtonWidth = 300.0;

  static TextButtonThemeData textButtonPrimaryCircularTheme(
      {BuildContext? context, ColorScheme? colorScheme}) {
    colorScheme = colorScheme ?? Theme.of(context ?? Get.context!).colorScheme;
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          primary: colorScheme.onSecondary,
          //textButtonColor
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          minimumSize: Size(0, _maxButtonHeight),
          maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: SnoseySizes.defaultBorderRadius,
          )),
    );
  }

  static TextButtonThemeData iconButtonCircleTheme(
      {BuildContext? context, ColorScheme? colorScheme}) {
    colorScheme = colorScheme ?? Theme.of(context ?? Get.context!).colorScheme;
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        primary: colorScheme.onSecondary,
        //textButtonColor
        shape: CircleBorder(),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        minimumSize: Size(0, _maxButtonHeight),
        maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
        elevation: 0,
      ),
    );
  }

  static TextButtonThemeData textButtonPrimaryRectTheme(
      {BuildContext? context, ColorScheme? colorScheme}) {
    colorScheme = colorScheme ?? Theme.of(context ?? Get.context!).colorScheme;
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          primary: colorScheme.onSecondary,
          //textButtonColor
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          minimumSize: Size(0, _maxButtonHeight),
          maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: SnoseySizes.recBorderRadius,
          )),
    );
  }

  static TextButtonThemeData transparentTextButton(
      {BuildContext? context, ColorScheme? colorScheme}) {
    colorScheme = colorScheme ?? Theme.of(context ?? Get.context!).colorScheme;
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          primary: colorScheme.onBackground,
          //textButtonColor
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          minimumSize: Size(0, _maxButtonHeight),
          maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: SnoseySizes.defaultBorderRadius,
          )),
    );
  }
}
