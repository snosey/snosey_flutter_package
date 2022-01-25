import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/SnoseyWeb.dart';
import 'package:snosey_flutter_package/utils/SnoseyLanguages.dart';
import 'package:snosey_flutter_package/utils/SnoseySizes.dart';

class SnoseyDialog {
  static showAlertDialog(
    BuildContext context, {
    required String content,
    String? title,
    String? buttonTitle,
  }) {
    Widget okButton = TextButton(
      child: Text(buttonTitle ?? SnoseyLanguagesKeys.ok.toString().tr),
      onPressed: () {},
    );

// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(content),
      actions: [
        okButton,
      ],
    );

// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static warningBottomSheet(context, String title, String content, {onPress}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return CustomWeb(context).width(
            child: Center(
              child: Wrap(
                children: [
                  ClipRRect(
                    child: Container(
                      color: Colors.white,
                      height: 150,
                      padding: EdgeInsets.all(SnoseySizes.defaultMargin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(title,
                              style: Theme.of(context).textTheme.headline6),
                          Expanded(
                            child: Center(
                              child: Text(content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.grey)),
                            ),
                          ),
                          TextButton(
                                  onPressed:
                                      onPress ?? () => Navigator.pop(context),
                                  child: Text(
                                    SnoseyLanguagesKeys.ok.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: SnoseySizes.defaultMargin),
                        ],
                      ),
                    ),
                  ).marginAll(SnoseySizes.defaultMargin),
                ],
              ),
            ),
          );
        });
  }

  static warningYesNoBottomSheet(
      context, String title, String content, Function yes, Function no) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (BuildContext bc) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                height: 150,
                width: 300,
                padding: EdgeInsets.all(SnoseySizes.defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface)),
                    Expanded(
                      child: Center(
                        child: Text(content,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.grey)),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                                  onPressed: () {
                                    yes.call();
                                  },
                                  child: Text(
                                    SnoseyLanguagesKeys.yes.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: SnoseySizes.defaultMargin / 2),
                        ),
                        Expanded(
                          child: TextButton(
                                  onPressed: () {
                                    no.call();
                                  },
                                  child: Text(
                                    SnoseyLanguagesKeys.no.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: SnoseySizes.defaultMargin / 2),
                        ),
                      ],
                    ).marginSymmetric(horizontal: SnoseySizes.defaultMargin / 2),
                  ],
                ),
              ),
            ).marginAll(SnoseySizes.defaultMargin),
          );
        });
  }
}
