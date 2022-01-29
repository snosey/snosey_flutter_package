import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class CommonTextField extends TextFormField {
  CommonTextField({
    required FormFieldValidator<String> validator,
    required TextInputType keyboardType,
    required String labelText,
    Widget? startIconWidget,
    Widget? endIconWidget,
    //////////////////////////
    bool showErrorAlways = true,
    bool? isPasswordVisible,
    TextEditingController? controller,
    bool? enabled,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    String? initialValue,
    List<TextInputFormatter>? inputFormatters,
    TextAlign textAlign = TextAlign.start,
  }) : super(
          controller: controller,
          enabled: enabled,
          maxLines: 1,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          obscureText: isPasswordVisible ?? false,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          decoration: InputDecoration().copyWith(
            labelText: labelText,
            suffixIcon: endIconWidget,
            prefixIcon: startIconWidget,
          ),
          autovalidateMode: showErrorAlways
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          readOnly: readOnly,
          textAlign: textAlign,
        );
}
