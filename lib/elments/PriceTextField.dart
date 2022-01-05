import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../MyLanguages.dart';
import 'CommonTextField.dart';

class PriceTextField extends CommonTextField {
  PriceTextField({
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    bool isRequired = true,
    String? initialValue,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    bool? showErrorAlways,
    Widget? startIconWidget,
    Widget? endIconWidget,
    String? labelText,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          labelText: labelText ?? MyLanguagesKeys.price.toString().tr,
          controller: controller,
          enabled: enabled,
    endIconWidget: endIconWidget,
    startIconWidget: startIconWidget,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          showErrorAlways: showErrorAlways ?? true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
          validator: (text) {
            if (isRequired && (text == null || text.isEmpty))
              return errorText ?? MyLanguagesKeys.priceError.toString().tr;
            else
              return null;
          },
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
