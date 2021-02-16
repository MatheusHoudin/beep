import 'package:beep/core/constants/routes.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  void routeSplashScreenToLoginScreen();
}

class AppRouterImpl extends AppRouter {
  @override
  void routeSplashScreenToLoginScreen() {
    Get.offAndToNamed(loginScreen);
  }
}
