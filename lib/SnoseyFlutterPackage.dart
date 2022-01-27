import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snosey_flutter_package/api/SnoseyApiController.dart';

class SnoseyFlutterPackage {
  static late String defaultLogoPath;
  static late String defaultFontPath;
  static late Widget Function(BuildContext) drawerWidgetList;

  static init({
    required String defaultLogoPath,
    required ColorScheme defaultColorScheme,
    required String defaultFontPath,
    required String baseUrl,
    required String serverErrorMessage,
    required Widget Function(BuildContext) drawerWidgetList,
  }) async {
    await GetStorage.init();
    SnoseyFlutterPackage.defaultLogoPath = defaultLogoPath;
    SnoseyFlutterPackage.defaultFontPath = defaultFontPath;
    SnoseyFlutterPackage.drawerWidgetList = drawerWidgetList;
    SnoseyApiController.init(
        baseUrl: baseUrl, serverErrorMessage: serverErrorMessage);
  }
}
