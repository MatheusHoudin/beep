import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:get/get.dart';

class RegisterCountingPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterCountingController>(() => RegisterCountingControllerImpl(
      getLoggedUserUseCase: Get.find()
    ));
  }
}
