import '../utils/DinnovaLanguages.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CommonTextField.dart';

class DinnovaNameTextField extends CommonTextField {
  DinnovaNameTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    Widget? startIconWidget,
    Widget? endIconWidget,
    String? labelText,
    String? errorText,
    bool? showErrorAlways,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText??DinnovaLanguagesKeys.name.toString().tr,
          controller: controller,
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
          enabled: enabled,
    endIconWidget: endIconWidget,
    startIconWidget: startIconWidget,
          showErrorAlways: showErrorAlways??true,
          keyboardType: TextInputType.name,
          validator: (text) {
            if (isRequired && (text == null || text.isEmpty))
              return errorText??DinnovaLanguagesKeys.thisFieldRequired.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
