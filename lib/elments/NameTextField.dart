import '../MyLanguages.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CommonTextField.dart';

class NameTextField extends CommonTextField {
  NameTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    String? labelText,
    String? errorText,
    bool? showErrorAlways,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText??MyLanguagesKeys.name.toString().tr,
          controller: controller,
          enabled: enabled,
          showErrorAlways: showErrorAlways??true,
          keyboardType: TextInputType.name,
          validator: (text) {
            if (isRequired && (text == null || text.isEmpty))
              return errorText??MyLanguagesKeys.thisFieldRequired.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
