import 'package:beep/features/login/domain/controller/login_page_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(() => LoginPageControllerImpl(Get.find()));
  }
}
