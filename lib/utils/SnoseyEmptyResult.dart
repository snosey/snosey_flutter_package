import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snosey_flutter_package/SnoseyFlutterPackage.dart';
import 'package:snosey_flutter_package/utils/SnoseyLanguages.dart';
import 'package:snosey_flutter_package/utils/SnoseySizes.dart';

class SnoseyEmptyResult extends StatefulWidget {
  const SnoseyEmptyResult({Key? key}) : super(key: key);

  @override
  _SnoseyEmptyResultState createState() => _SnoseyEmptyResultState();
}

class _SnoseyEmptyResultState extends State<SnoseyEmptyResult> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: 200,
            width: 200,
            image: AssetImage(SnoseyFlutterPackage.defaultLogoPath),
            fit: BoxFit.fitWidth,
          ),
          Text(
            SnoseyLanguagesKeys.noResultsFound.toString().tr,
            style: Theme.of(context).textTheme.headline3,
          ).marginAll(SnoseySizes.defaultMargin),
        ],
      ).marginAll(SnoseySizes.defaultMargin * 2),
    );
  }
}
