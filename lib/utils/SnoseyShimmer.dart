import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SnoseyShimmer {
  static Widget get({required Widget child, required BuildContext context}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
      highlightColor:
          Theme.of(context).colorScheme.onBackground.withOpacity(.1),
      child: child,
    );
  }
}
