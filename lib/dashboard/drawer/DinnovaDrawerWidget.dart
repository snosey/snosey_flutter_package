import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dinnova/DinnovaFlutterPackage.dart';

class DinnovaDrawerUtils {
  static final double minWidth = 1000;

  static var isBigThanDrawer = (Get.width < minWidth).obs;

  checkScreenSize() {
    isBigThanDrawer.value = Get.width < minWidth;
  }
}

class DinnovaDrawerWidget extends StatefulWidget {
  final Widget child;
  final AppBar? appBar;

  DinnovaDrawerWidget({required this.child, this.appBar});

  @override
  State<StatefulWidget> createState() => _DinnovaDrawerWidgetState();
}

class _DinnovaDrawerWidgetState extends State<DinnovaDrawerWidget> {
  DinnovaDrawerUtils customDrawerUtils = DinnovaDrawerUtils();
  double iconSize = 20;

  late BuildContext baseContext;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: widget.appBar != null
            ? AppBar(
                backgroundColor: widget.appBar!.backgroundColor,
                centerTitle: false,
                actions: addSideMenuButton(),
                title: widget.appBar!.title,
                titleSpacing: 22,
                bottom: widget.appBar!.bottom,
                //  leading: widget.appBar!.leading,
                toolbarHeight: widget.appBar!.toolbarHeight,
                leading: Navigator.canPop(context) ? BackButton() : null,
                titleTextStyle: widget.appBar!.titleTextStyle,
              )
            : AppBar(
                leading: Navigator.canPop(context) ? BackButton() : null,
                actions: [],
              ),
        endDrawer: DinnovaDrawerUtils.isBigThanDrawer.value
            ? SafeArea(child: DinnovaFlutterPackage.drawerWidgetList(context))
            : null,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            baseContext = context;
            customDrawerUtils.checkScreenSize();
            return Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: widget.child),
                  ],
                )),
                //      customDrawerUtils.isBigThanDrawer ? Container() : customDrawerUtils.drawerWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }

  List<Widget> addSideMenuButton() {
    List<Widget> actionList = [];
    actionList.addAll(widget.appBar!.actions ?? []);
    if (DinnovaDrawerUtils.isBigThanDrawer.value)
      actionList.add(IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(baseContext).openEndDrawer();
        },
      ));
    return actionList;
  }
}
