import 'package:flutter/material.dart';

class DinnovaTabBarItem {
  final Object? key;
  Widget _widget;
  String tabText;
  Widget tabIcon;
  bool isScroll;
  ScrollController? scrollController;

  DinnovaTabBarItem(
    this._widget, {
    required this.tabText,
    required this.tabIcon,
    this.isScroll = false,
    this.scrollController,
    this.key,
  });

  Widget getWidget() {
    if (!isScroll)
      return _widget;
    else
      return Builder(builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: _widget,
            )
          ],
        );
      });
  }
}
