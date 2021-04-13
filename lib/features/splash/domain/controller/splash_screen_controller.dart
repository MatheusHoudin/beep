import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/splash/domain/usecase/save_onboarding_done_usecase.dart';
import 'package:beep/shared/model/splash_page_data.dart';
import 'package:get/get.dart';

abstract class SplashScreenController extends GetxController {
  void nextPage();

  void previousPage();

  void skip();

  void updatePage(int page);

  String getBackgroundImageUrl(int index);

  String getInfo(int index);

  String getStepImageUrl();

  bool shouldShowSkipButton();

  int getCurrentPage();
}

class SplashScreenControllerImpl extends SplashScreenController {
  final List<SplashPageData> _splashPagesData = [
    SplashPageData(
        image: splashFirstBackground, text: splashFirstText, step: stepsFirst),
    SplashPageData(
        image: splashSecondBackground,
        text: splashSecondText,
        step: stepsSecond),
    SplashPageData(
        image: splashThirdBackground, text: splashThirdText, step: stepsThird)
  ];
  var selectedSplashPage = SplashPageData(step: stepsFirst).obs;
  final currentIndex = 0.obs;

  final SaveOnboardingDoneUsecase _saveOnboardingDoneUseCase;
  final AppRouter _router;

  SplashScreenControllerImpl([this._saveOnboardingDoneUseCase, this._router]);

  @override
  void nextPage() {
    if (currentIndex.value == _splashPagesData.length - 1) {
      _saveOnboardingAndContinueToLogin();
      return;
    }
    currentIndex.value++;
    selectedSplashPage = _splashPagesData[currentIndex.value].obs;
    update();
  }

  @override
  void previousPage() {
    if (currentIndex.value == 0) return;

    currentIndex.value--;
    selectedSplashPage = _splashPagesData[currentIndex.value].obs;
    update();
  }

  @override
  void updatePage(int page) {
    if (page < currentIndex.value) {
      previousPage();
    } else if (page > currentIndex.value) {
      nextPage();
    }
  }

  @override
  void skip() {
    _saveOnboardingAndContinueToLogin();
  }

  void _saveOnboardingAndContinueToLogin() {
    _saveOnboardingDoneUseCase.call(SaveOnboardingParams(value: true));
    _router.routeSplashPageToLoginPage();
  }

  @override
  String getBackgroundImageUrl(int index) {
    return _splashPagesData[index].image;
  }

  @override
  String getInfo(int index) {
    return _splashPagesData[index].text;
  }

  @override
  String getStepImageUrl() {
    return selectedSplashPage.value.step;
  }

  @override
  bool shouldShowSkipButton() {
    return currentIndex.value == 0;
  }

  @override
  int getCurrentPage() {
    return currentIndex.value;
  }
}
