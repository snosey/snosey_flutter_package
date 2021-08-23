library snosey_flutter_package;

import 'package:flutter/material.dart';
import 'package:snosey_flutter_package/api/ApiController.dart';
import 'package:snosey_flutter_package/res/MyLanguages.dart';
import 'package:timeago/timeago.dart' as timeago;

class SnoseyFlutter {
 static init() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    }
}
