import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/TestWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'MyLanguages.dart';
import 'elments/EmailTextField.dart';
import 'elments/NameTextField.dart';
import 'elments/NoteTextField.dart';
import 'elments/PhoneTextField.dart';
import 'elments/PriceTextField.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    return runApp(MainCommon());
  });
}

class MainCommon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale("ar"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: MyLanguages(),
      supportedLocales: [Locale("ar"), Locale("en")],
      debugShowCheckedModeBanner: false,
      home: TestWidget(),
    );
  }
}
