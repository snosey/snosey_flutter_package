import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/utils/SnoseySizes.dart';

import 'SnoseyLanguages.dart';

class SnoseyProgressLoading {
  static Widget showFullDialog(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(SnoseySizes.defaultMargin / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SnoseySizes.defaultMargin),
                    child: Text(SnoseyLanguagesKeys.loadingPleaseWait.toString().tr,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Theme.of(context).colorScheme.primary))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget showIndicator(context, {Color? color}) {
    if (color == null) color = Theme.of(context).colorScheme.primary;
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      ).marginAll(SnoseySizes.defaultMargin),
    );
  }

  static showAlertLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: showIndicator(context),
        );
      },
    );
  }
}
