import 'package:flutter/material.dart';

class CustomLanguage {
  final Map<String, String> _english = new Map();
  final Map<String, String> _arabic = new Map();
  late BuildContext _context;

  init(BuildContext context) {
    _context = context;
  }

  add({required String key, String? arValue, String? enValue}) {
    if (arValue != null) _arabic[key] = arValue;
    if (enValue != null) _english[key] = enValue;
  }

  String get(String key) {
    var lan = Localizations.localeOf(_context);
    if (lan.languageCode == "en") {
      return _english[key] ?? key;
    } else if (lan.languageCode == "ar") {
      return _arabic[key] ?? key;
    } else {
      return _english[key] ?? key;
    }
  }
}
