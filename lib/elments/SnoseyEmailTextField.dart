import '../utils/SnoseyLanguages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/SnoseyLanguages.dart';
import 'CommonTextField.dart';

class SnoseyEmailTextField extends CommonTextField {
  SnoseyEmailTextField({
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
          labelText: labelText ?? SnoseyLanguagesKeys.email.toString().tr,
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
              return errorText ?? SnoseyLanguagesKeys.emailError.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
