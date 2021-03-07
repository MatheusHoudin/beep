import 'package:beep/core/constants/routes.dart';
import 'package:get/get.dart';

abstract class AppRouter {
  void routeSplashPageToLoginPage();
  void routeLoginPageToRegisterPage();
  void routeLoginPageToHomePage();
  void back();
}

class AppRouterImpl extends AppRouter {
  @override
  void routeSplashPageToLoginPage() {
    Get.offAndToNamed(loginPage);
  }

  @override
  void routeLoginPageToRegisterPage() {
    Get.toNamed(registerPage);
  }

  @override
  void back() {
    Get.back();
  }

  @override
  void routeLoginPageToHomePage() {
    Get.offAndToNamed(homeRouterPage);
  }
}
