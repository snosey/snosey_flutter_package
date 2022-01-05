import '../MyLanguages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MyLanguages.dart';
import 'CommonTextField.dart';

class EmailTextField extends CommonTextField {
  EmailTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    bool? showErrorAlways,
    ValueChanged<String>? onChanged,
    Widget? startIconWidget,
    Widget? endIconWidget,
    VoidCallback? onEditingComplete,
    String? labelText,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText ?? MyLanguagesKeys.email.toString().tr,
          controller: controller,
          enabled: enabled,
    endIconWidget: endIconWidget,
    startIconWidget: startIconWidget,
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
          showErrorAlways: showErrorAlways??true,
          keyboardType: TextInputType.emailAddress,
          validator: (text) {
            if (isRequired && (text == null || !GetUtils.isEmail(text)))
              return errorText ?? MyLanguagesKeys.emailError.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
