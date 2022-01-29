import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinnova/DinnovaFlutterPackage.dart';
import 'package:dinnova/utils/DinnovaLanguages.dart';
import 'package:dinnova/utils/DinnovaSizes.dart';

class DinnovaEmptyResult extends StatefulWidget {
  const DinnovaEmptyResult({Key? key}) : super(key: key);

  @override
  _DinnovaEmptyResultState createState() => _DinnovaEmptyResultState();
}

class _DinnovaEmptyResultState extends State<DinnovaEmptyResult> {
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
            image: AssetImage(DinnovaFlutterPackage.defaultLogoPath),
            fit: BoxFit.fitWidth,
          ),
          Text(
            DinnovaLanguagesKeys.noResultsFound.toString().tr,
            style: Theme.of(context).textTheme.headline3,
          ).marginAll(DinnovaSizes.defaultMargin),
        ],
      ).marginAll(DinnovaSizes.defaultMargin * 2),
    );
  }
}
