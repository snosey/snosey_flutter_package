import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snosey_flutter_package/elments/SnoseyEmailTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseyNameTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseyNoteTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseyPasswordTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseyPhoneTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseyPriceTextField.dart';
import 'package:snosey_flutter_package/elments/SnoseySearchTextField.dart';

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var isPasswordVisible = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SnoseyNameTextField().marginAll(10),
            SnoseyEmailTextField().marginAll(10),
            SnoseyPhoneTextField().marginAll(10),
            SnoseyPriceTextField().marginAll(10),
            SnoseyNoteTextField().marginAll(10),
            SnoseySearchTextField(
                controller: searchController,
                inputDecoration: TextField().decoration!,
                onEditingComplete: () {
                },
                onChanged: (text) {},
                storage: GetStorage(),
                searchKey: "test"),
            Obx(() => SnoseyPasswordTextField(
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
