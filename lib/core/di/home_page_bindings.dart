import 'package:beep/features/home/domain/router/controller/home_router_controller.dart';
import 'package:beep/features/home/domain/router/usecase/home_router_use_case.dart';
import 'package:beep/shared/datasource/home/router/home_router_local_datasource.dart';
import 'package:beep/shared/repository/home/router/home_router_repository.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeRouterLocalDataSource>(HomeRouterLocalDataSourceImpl(
      sharedPreferences: Get.find()
    ));
    Get.put<HomeRouterRepository>(HomeRouterRepositoryImpl(
      dataSource: Get.find()
    ));
    Get.put<HomeRouterUseCase>(HomeRouterUseCase(
      repository: Get.find()
    ));
    Get.put<HomeRouterController>(HomeRouterControllerImpl(
      useCase: Get.find()
    ));
  }
}
