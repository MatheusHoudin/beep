import 'package:beep/core/router/app_router.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRouter>(AppRouterImpl());
  }
}
