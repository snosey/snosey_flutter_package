import 'package:flutter/material.dart';

class CustomLanguage {
  static final Map<String, String> _english = new Map();
  static final Map<String, String> _arabic = new Map();
  static late BuildContext _context;

  static init(BuildContext context) {
    CustomLanguage._context = context;
  }

  static add({required String key, String? arValue, String? enValue}) {
    if (arValue != null) _arabic[key] = arValue;
    if (enValue != null) _english[key] = enValue;
  }

  static String get({required String key}) {
    var lan = Localizations.localeOf(CustomLanguage._context);
    if (lan.languageCode == "en") {
      return _english[key] ?? key;
    } else if (lan.languageCode == "ar") {
      return _arabic[key] ?? key;
    } else {
      return _english[key] ?? key;
    }
  }
}
