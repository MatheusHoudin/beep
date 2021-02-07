import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/splash_page_data.dart';
import 'package:get/get.dart';

abstract class SplashScreenController {
  void nextPage();
  void previousPage();
  void skip();
}

class SplashScreenControllerImpl extends GetxController implements SplashScreenController {
  final List<SplashPageData> _splashPagesData = [
    SplashPageData(image: splashFirstBackground, text: splashFirstText),
    SplashPageData(image: splashSecondBackground, text: splashSecondText),
    SplashPageData(image: splashThirdBackground, text: splashThirdText)
  ];
  var selectedSplashPage = SplashPageData(image: splashFirstBackground, text: splashFirstText).obs;
  final currentIndex = 0.obs;

  @override
  void nextPage() {
    if (currentIndex.value == _splashPagesData.length - 1) {

      return;
    }
    currentIndex.value++;
    selectedSplashPage = _splashPagesData[currentIndex.value].obs;
  }

  @override
  void previousPage() {
    if (currentIndex.value == 0) return;

    currentIndex.value--;
    selectedSplashPage = _splashPagesData[currentIndex.value].obs;
  }

  @override
  void skip() {
    // TODO: implement skip
  }

}
