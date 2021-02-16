import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/splash/domain/controller/splash_screen_controller.dart';
import 'package:beep/features/splash/domain/usecase/save_onboarding_done_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAppRouter extends Mock implements AppRouter {}
class MockSaveOnboardingDoneUseCase extends Mock implements SaveOnboardingDoneUsecase {}

void main() {
  MockAppRouter mockAppRouter;
  MockSaveOnboardingDoneUseCase mockSaveOnboardingDoneUseCase;
  SplashScreenController splashScreenController;

  setUp(() {
    mockAppRouter = MockAppRouter();
    mockSaveOnboardingDoneUseCase = MockSaveOnboardingDoneUseCase();
    splashScreenController = SplashScreenControllerImpl(mockSaveOnboardingDoneUseCase, mockAppRouter);
  });

  test('Should return selected splash page image url', () {
    var selectedSplashPageImage = splashScreenController.getBackgroundImageUrl();

    expect(selectedSplashPageImage, splashFirstBackground);
  });

  test('Should return selected splash page info', () {
    var selectedSplashPageInfo = splashScreenController.getInfo();

    expect(selectedSplashPageInfo, splashFirstText);
  });

  test('Should return selected splash page step image url', () {
    var selectedSplashPageStepImageUrl = splashScreenController.getStepImageUrl();

    expect(selectedSplashPageStepImageUrl, stepsFirst);
  });

  test('Should return true when current index is zero', () {
    var shouldShowSkipButton = splashScreenController.shouldShowSkipButton();

    expect(shouldShowSkipButton, true);
  });

  test('Should save onboarding done and route to login screen', () {
    splashScreenController.skip();

    verify(mockSaveOnboardingDoneUseCase.call(SaveOnboardingParams(value: true)));
    verify(mockAppRouter.routeSplashScreenToLoginScreen());
  });

  test('Should select next splash page when current page is first', () {
    splashScreenController.nextPage();

    expect(splashSecondBackground, splashScreenController.getBackgroundImageUrl());
    expect(splashSecondText, splashScreenController.getInfo());
    expect(stepsSecond, splashScreenController.getStepImageUrl());
  });

  test('Should select next splash page when current page is second', () {
    splashScreenController.nextPage();
    splashScreenController.nextPage();

    expect(splashThirdBackground, splashScreenController.getBackgroundImageUrl());
    expect(splashThirdText, splashScreenController.getInfo());
    expect(stepsThird, splashScreenController.getStepImageUrl());
  });

  test('Should save onboarding done and route to login screen when going to next page with current index is the last', () {
    splashScreenController.nextPage();
    splashScreenController.nextPage();
    splashScreenController.nextPage();

    verify(mockSaveOnboardingDoneUseCase.call(SaveOnboardingParams(value: true)));
    verify(mockAppRouter.routeSplashScreenToLoginScreen());
  });

  test('Should do nothing when selecting previous page but page index is zero', () {
    splashScreenController.previousPage();

    expect(splashFirstBackground, splashScreenController.getBackgroundImageUrl());
    expect(splashFirstText, splashScreenController.getInfo());
    expect(stepsFirst, splashScreenController.getStepImageUrl());
  });

  test('Should go back one page when selecting previous page but page index is three', () {
    splashScreenController.nextPage();
    splashScreenController.nextPage();
    splashScreenController.previousPage();

    expect(splashSecondBackground, splashScreenController.getBackgroundImageUrl());
    expect(splashSecondText, splashScreenController.getInfo());
    expect(stepsSecond, splashScreenController.getStepImageUrl());
  });

  test('Should go back one page when selecting previous page but page index is two', () {
    splashScreenController.nextPage();
    splashScreenController.previousPage();

    expect(splashFirstBackground, splashScreenController.getBackgroundImageUrl());
    expect(splashFirstText, splashScreenController.getInfo());
    expect(stepsFirst, splashScreenController.getStepImageUrl());
  });
}
