import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snosey_flutter_package/SnoseyFlutterPackage.dart';

import 'SnoseyProgressLoading.dart';

class SnoseyImage {
  static Widget getImage(
    String url, {
    fit = BoxFit.cover,
    double height = double.infinity,
    double width = double.infinity,
    Widget? indicator,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, __) =>
          indicator ??
          Center(child: SnoseyProgressLoading.showIndicator(context)),
      errorWidget: (context, url, error) =>
          Image.asset(SnoseyFlutterPackage.defaultLogoPath),
    );
  }
}
