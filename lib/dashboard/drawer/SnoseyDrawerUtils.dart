import 'package:snosey_flutter_package/utils/SnoseySizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/utils/StorageManager.dart';

final double minWidth = 1000;

var isBigThanDrawer = (Get.width < minWidth).obs;

Widget getExpansionWidget(BuildContext context,
    {required String title,
    required List<Widget> children,
    bool initiallyExpanded = false,
    required String icon}) {
  return Theme(
    data: Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    ),
    child: ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getTileWidgetIcon(icon,context),
          Expanded(child: Text(title)),
        ],
      ),
      children: children,
      backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
      childrenPadding: EdgeInsets.symmetric(horizontal: SnoseySizes.defaultMargin),
    ),
  );
}

Widget getTileWidget(
  String text, {
  GestureTapCallback? onTap,
  Widget? icon,
}) {
  return ListTile(
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: icon,
        ),
        Expanded(child: Text(text)),
      ],
    ),
    onTap: onTap,
  );
}

Widget getTileWidgetIcon(String icon, BuildContext context) {
  return Padding(
    padding: EdgeInsetsDirectional.only(end: SnoseySizes.defaultMargin),
    child: Image.asset(
      icon,
      color: Theme.of(context).colorScheme.primary,
      height: 27,
      width: 27,
    ),
  );
}

onNotificationTap() {}

onLogoutTap() {}

