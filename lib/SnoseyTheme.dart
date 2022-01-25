import 'package:flutter/material.dart';
import 'package:snosey_flutter_package/SnoseyFlutterPackage.dart';
import 'package:snosey_flutter_package/utils/SnoseySizes.dart';

class SnoseyButtonThemes {
  static final double _maxButtonHeight = 40.0;
  static final double _maxButtonWidth = 300.0;

  static final TextButtonThemeData textButtonPrimaryCircularTheme =
      TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: SnoseyFlutterPackage.defaultColorScheme.secondary,
        primary: SnoseyFlutterPackage.defaultColorScheme.onSecondary,
        //textButtonColor
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        minimumSize: Size(0, _maxButtonHeight),
        maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: SnoseySizes.defaultBorderRadius,
        )),
  );

  static final TextButtonThemeData iconButtonCircleTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: SnoseyFlutterPackage.defaultColorScheme.secondary,
      primary: SnoseyFlutterPackage.defaultColorScheme.onSecondary,
      //textButtonColor
      shape: CircleBorder(),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      minimumSize: Size(0, _maxButtonHeight),
      maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
      elevation: 0,
    ),
  );

  static final TextButtonThemeData textButtonPrimaryRectTheme =
      TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: SnoseyFlutterPackage.defaultColorScheme.secondary,
        primary: SnoseyFlutterPackage.defaultColorScheme.onSecondary,
        //textButtonColor
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        minimumSize: Size(0, _maxButtonHeight),
        maximumSize: Size(_maxButtonWidth, _maxButtonHeight),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: SnoseySizes.recBorderRadius,
        )),
  );

  static final TextButtonThemeData transparentTextButton = TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        primary: SnoseyFlutterPackage.defaultColorScheme.onBackground,
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
