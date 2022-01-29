import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinnova/utils/DinnovaLanguages.dart';

import 'DinnovaStorageManager.dart';

class DinnovaMode {
  static changeThemeMode(String key) {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    DinnovaStorageManager.saveData(key, Get.isDarkMode);
  }

  static changeLanguageMode() {
    // Support AR & EN
    var ar = "ar";
    var en = "en";
    if (Get.locale!.languageCode == ar) {
      DinnovaStorageManager.saveData(
          DinnovaLanguagesKeys.language.toString(), en);
      Get.updateLocale(Locale(en));
    } else if (Get.locale!.languageCode == en) {
      DinnovaStorageManager.saveData(
          DinnovaLanguagesKeys.language.toString(), ar);
      Get.updateLocale(Locale(ar));
    }
  }
}
