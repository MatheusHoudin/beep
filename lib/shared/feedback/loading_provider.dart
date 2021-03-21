import 'package:beep/shared/widgets/fullscreen_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoadingProvider {
  void showFullscreenLoading();
  void hideFullscreenLoading();
}

class LoadingProviderImpl extends LoadingProvider {
  @override
  void hideFullscreenLoading() {
    Get.back();
  }

  @override
  void showFullscreenLoading() {
    Get.dialog(
      Container(
        height: Get.size.height,
        width: Get.size.width,
        child: FullScreenLoading(),
      ),
      barrierDismissible: false
    );
  }
}
