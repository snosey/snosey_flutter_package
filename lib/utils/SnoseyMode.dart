import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/utils/SnoseyLanguages.dart';

import 'StorageManager.dart';

class SnoseyMode {
  static changeThemeMode() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    SnoseyStorageManager.saveData("isDarkMode", Get.isDarkMode);
  }

  static changeLanguageMode() {
    // Support AR & EN
    var ar = "ar";
    var en = "en";
    if (Get.locale!.languageCode == ar) {
      SnoseyStorageManager.saveData(
          SnoseyLanguagesKeys.language.toString(), en);
      Get.updateLocale(Locale(en));
    } else if (Get.locale!.languageCode == en) {
      SnoseyStorageManager.saveData(
          SnoseyLanguagesKeys.language.toString(), ar);
      Get.updateLocale(Locale(ar));
    }
  }
}
