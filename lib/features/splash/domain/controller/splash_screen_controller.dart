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

  String getBackgroundImageUrl();

  String getInfo();

  String getStepImageUrl();

  bool shouldShowSkipButton();
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
  var selectedSplashPage = SplashPageData(
          image: splashFirstBackground, text: splashFirstText, step: stepsFirst)
      .obs;
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
  void skip() {
    _saveOnboardingAndContinueToLogin();
  }

  void _saveOnboardingAndContinueToLogin() {
    _saveOnboardingDoneUseCase.call(SaveOnboardingParams(value: true));
    _router.routeSplashScreenToLoginScreen();
  }

  @override
  String getBackgroundImageUrl() {
    return selectedSplashPage.value.image;
  }

  @override
  String getInfo() {
    return selectedSplashPage.value.text;
  }

  @override
  String getStepImageUrl() {
    return selectedSplashPage.value.step;
  }

  @override
  bool shouldShowSkipButton() {
    return currentIndex.value == 0;
  }
}
