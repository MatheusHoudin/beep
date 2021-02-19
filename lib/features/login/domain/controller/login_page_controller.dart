import 'package:get/get.dart';

abstract class LoginPageController extends GetxController {
  bool isPasswordVisible();
  void togglePasswordVisibility();
}

class LoginPageControllerImpl extends LoginPageController {

  var _isPasswordVisible = false.obs;

  @override
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
    update();
  }

  @override
  bool isPasswordVisible() {
    return _isPasswordVisible.value;
  }
}
