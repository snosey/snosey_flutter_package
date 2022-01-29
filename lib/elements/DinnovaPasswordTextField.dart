import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/DinnovaLanguages.dart';
import 'CommonTextField.dart';

class DinnovaPasswordTextField extends CommonTextField {
  DinnovaPasswordTextField({
    required bool isPasswordVisible,
    required VoidCallback onChangeVisibleClick,
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    bool? showErrorAlways,
    String? labelText,
    String? errorText,
    Widget? startIconWidget,
    Widget? endIconWidget,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText ?? DinnovaLanguagesKeys.password.toString().tr,
          controller: controller,
          enabled: enabled,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          startIconWidget: startIconWidget,
          isPasswordVisible: isPasswordVisible,
          showErrorAlways: showErrorAlways ?? true,
          endIconWidget: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: onChangeVisibleClick,
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (text) {
            if (isRequired && (text == null || text.length < 6))
              return errorText ??
                  DinnovaLanguagesKeys.passwordHintError.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
