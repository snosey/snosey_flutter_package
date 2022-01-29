import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension DinnovaTextExtension on TextStyle {
  TextStyle underline({Color? color}) {
   return this.copyWith(
      shadows: [
        Shadow(
            color: color ?? Get.theme.colorScheme.primary,
            offset: Offset(0, -4))
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor:color ?? Get.theme.colorScheme.primary,
      decorationThickness: 2,
      decorationStyle: TextDecorationStyle.solid,
    );
  }
}
