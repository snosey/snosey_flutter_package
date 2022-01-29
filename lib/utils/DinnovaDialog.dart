import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinnova/DinnovaWeb.dart';
import 'package:dinnova/utils/DinnovaLanguages.dart';
import 'package:dinnova/utils/DinnovaSizes.dart';

class DinnovaDialog {
  static showAlertDialog(
    BuildContext context, {
    required String content,
    String? title,
    String? buttonTitle,
  }) {
    Widget okButton = TextButton(
      child: Text(buttonTitle ?? DinnovaLanguagesKeys.ok.toString().tr),
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
                      padding: EdgeInsets.all(DinnovaSizes.defaultMargin),
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
                                    DinnovaLanguagesKeys.ok.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: DinnovaSizes.defaultMargin),
                        ],
                      ),
                    ),
                  ).marginAll(DinnovaSizes.defaultMargin),
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
                padding: EdgeInsets.all(DinnovaSizes.defaultMargin),
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
                                    DinnovaLanguagesKeys.yes.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: DinnovaSizes.defaultMargin / 2),
                        ),
                        Expanded(
                          child: TextButton(
                                  onPressed: () {
                                    no.call();
                                  },
                                  child: Text(
                                    DinnovaLanguagesKeys.no.toString().tr,
                                  ))
                              .marginSymmetric(
                                  horizontal: DinnovaSizes.defaultMargin / 2),
                        ),
                      ],
                    ).marginSymmetric(horizontal: DinnovaSizes.defaultMargin / 2),
                  ],
                ),
              ),
            ).marginAll(DinnovaSizes.defaultMargin),
          );
        });
  }
}
