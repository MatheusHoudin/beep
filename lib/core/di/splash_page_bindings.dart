import 'package:beep/features/splash/domain/controller/splash_screen_controller.dart';
import 'package:beep/features/splash/domain/usecase/save_onboarding_done_usecase.dart';
import 'package:get/get.dart';

class SplashPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaveOnboardingDoneUsecase>(() => SaveOnboardingDoneUsecase(Get.find()));
    Get.lazyPut<SplashScreenController>(() => SplashScreenControllerImpl(Get.find(), Get.find()));
  }
}
