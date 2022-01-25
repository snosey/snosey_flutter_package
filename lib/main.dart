import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snosey_flutter_package/TestWidget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'utils/SnoseyLanguages.dart';
import 'elments/SnoseyEmailTextField.dart';
import 'elments/SnoseyNameTextField.dart';
import 'elments/SnoseyNoteTextField.dart';
import 'elments/SnoseyPhoneTextField.dart';
import 'elments/SnoseyPriceTextField.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await GetStorage.init();
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
      translations: SnoseyLanguages(),
      supportedLocales: [Locale("ar"), Locale("en")],
      debugShowCheckedModeBanner: false,
      home: TestWidget(),
    );
  }
}
