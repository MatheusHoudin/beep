import 'package:beep/shared/widgets/fullscreen_loading.dart';
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
    Get.dialog(FullScreenLoading());
  }
}
