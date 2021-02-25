import 'package:beep/core/network/network_info.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppRouter>(AppRouterImpl());
    Get.put<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()));
  }
}
