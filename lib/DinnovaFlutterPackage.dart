import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dinnova/api/DinnovaApiController.dart';

class DinnovaFlutterPackage {
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
    DinnovaFlutterPackage.defaultLogoPath = defaultLogoPath;
    DinnovaFlutterPackage.defaultFontPath = defaultFontPath;
    DinnovaFlutterPackage.drawerWidgetList = drawerWidgetList;
    DinnovaApiController.init(
        baseUrl: baseUrl, serverErrorMessage: serverErrorMessage);
  }
}
