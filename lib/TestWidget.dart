import 'package:dinnova/elements/DinnovaEmailTextField.dart';
import 'package:dinnova/elements/DinnovaNameTextField.dart';
import 'package:dinnova/elements/DinnovaNoteTextField.dart';
import 'package:dinnova/elements/DinnovaPasswordTextField.dart';
import 'package:dinnova/elements/DinnovaPhoneTextField.dart';
import 'package:dinnova/elements/DinnovaPriceTextField.dart';
import 'package:dinnova/elements/DinnovaSearchTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
            DinnovaNameTextField().marginAll(10),
            DinnovaEmailTextField().marginAll(10),
            DinnovaPhoneTextField().marginAll(10),
            DinnovaPriceTextField().marginAll(10),
            DinnovaNoteTextField().marginAll(10),
            DinnovaSearchTextField(
                controller: searchController,
                inputDecoration: TextField().decoration!,
                onEditingComplete: () {},
                onChanged: (text) {},
                storage: GetStorage(),
                searchKey: "test"),
            Obx(() => DinnovaPasswordTextField(
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
