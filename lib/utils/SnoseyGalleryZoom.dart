import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SnoseyGalleryZoom {
  final List<String> imgList;
  final int currentIndex;
  final BuildContext context;

  SnoseyGalleryZoom(this.imgList, this.currentIndex, this.context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return _build();
        });
  }

  Widget _build() {
    PageController pageController = PageController(initialPage: currentIndex);
    var _current = currentIndex.obs;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Get.back();
                  }),
            ),
            Expanded(
              child: Stack(
                children: [
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(imgList[index]),
                          errorBuilder: (context, url, error) =>
                              Icon(Icons.image_outlined));
                    },
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent),
                    itemCount: imgList.length,
                    loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    pageController: pageController,
                    onPageChanged: (index) {
                      _current.value = index;
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.map((url) {
                            int index = imgList.indexOf(url);
                            return Obx(
                              () => Container(
                                width: 15.0,
                                height: 15.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current.value == index
                                      ? Theme.of(context).buttonColor
                                      : Theme.of(context)
                                          .buttonColor
                                          .withOpacity(.3),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
