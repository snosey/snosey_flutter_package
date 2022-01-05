import '../MyLanguages.dart';import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'CommonTextField.dart';

class PhoneTextField extends CommonTextField {
  PhoneTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    bool? showErrorAlways,
    String? labelText,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText ?? MyLanguagesKeys.phoneNumber.toString().tr,
          controller: controller,
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
          enabled: enabled,
    showErrorAlways: showErrorAlways??true,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (text) {
            if (isRequired &&
                (text == null ||
                    !GetUtils.isPhoneNumber(text) ||
                    (text.length != 10 && text.length != 11)))
              return errorText??MyLanguagesKeys.phoneHintError.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
