import '../utils/SnoseyLanguages.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CommonTextField.dart';

class SnoseyNoteTextField extends CommonTextField {
  SnoseyNoteTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    bool isRequired = true,
    String? initialValue,
    String? labelText,
    Widget? startIconWidget,
    Widget? endIconWidget,
    bool? showErrorAlways,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText??SnoseyLanguagesKeys.notes.toString().tr,
          controller: controller,
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
    endIconWidget: endIconWidget,
    startIconWidget: startIconWidget,
    showErrorAlways: showErrorAlways??true,
          enabled: enabled,
          keyboardType: TextInputType.multiline,
          validator: (text) {
            if (isRequired && (text == null || text.isEmpty))
              return errorText??SnoseyLanguagesKeys.thisFieldRequired.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
