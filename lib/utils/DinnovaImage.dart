import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dinnova/DinnovaFlutterPackage.dart';

import 'DinnovaProgressLoading.dart';

class DinnovaImage {
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
          Center(child: DinnovaProgressLoading.showIndicator(context)),
      errorWidget: (context, url, error) =>
          Image.asset(DinnovaFlutterPackage.defaultLogoPath),
    );
  }
}
