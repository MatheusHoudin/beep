import 'package:beep/core/router/app_router.dart';
import 'package:get/get.dart';

abstract class LoginPageController extends GetxController {
  bool isPasswordVisible();
  void togglePasswordVisibility();
  void continueToRegisterPage();
}

class LoginPageControllerImpl extends LoginPageController {

  var _isPasswordVisible = false.obs;

  final AppRouter _router;

  LoginPageControllerImpl([this._router]);

  @override
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
    update();
  }

  @override
  bool isPasswordVisible() {
    return _isPasswordVisible.value;
  }

  @override
  void continueToRegisterPage() {
    _router.routeLoginPageToRegisterPage();
  }
}
