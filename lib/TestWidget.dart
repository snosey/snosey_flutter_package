import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/elments/EmailTextField.dart';
import 'package:snosey_flutter_package/elments/NameTextField.dart';
import 'package:snosey_flutter_package/elments/NoteTextField.dart';
import 'package:snosey_flutter_package/elments/PasswordTextField.dart';
import 'package:snosey_flutter_package/elments/PhoneTextField.dart';
import 'package:snosey_flutter_package/elments/PriceTextField.dart';

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            NameTextField().marginAll(10),
            EmailTextField().marginAll(10),
            PhoneTextField().marginAll(10),
            PriceTextField().marginAll(10),
            NoteTextField().marginAll(10),
            Obx(() => PasswordTextField(
                  onChangeVisibleClick: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                  isPasswordVisible: isPasswordVisible.value,
                ).marginAll(10)),
          ],
        ),
      ),
    );
  }
}
