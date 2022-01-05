import '../MyLanguages.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CommonTextField.dart';

class NoteTextField extends CommonTextField {
  NoteTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    String? labelText,
    bool? showErrorAlways,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText??MyLanguagesKeys.notes.toString().tr,
          controller: controller,
    showErrorAlways: showErrorAlways??true,
          enabled: enabled,
          keyboardType: TextInputType.multiline,
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
