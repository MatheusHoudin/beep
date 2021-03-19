import 'package:beep/features/home/domain/controller/company_controller.dart';
import 'package:beep/features/home/domain/controller/home_router_controller.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/repository/home/get_logged_user_repository.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserLocalDataSource>(UserLocalDataSourceImpl(
      sharedPreferences: Get.find()
    ));
    Get.put<GetLoggedUserRepository>(GetLoggedUserRepositoryImpl(
      dataSource: Get.find()
    ));
    Get.put<GetLoggedUserUseCase>(GetLoggedUserUseCase(
      repository: Get.find()
    ));
    Get.put<HomeRouterController>(HomeRouterControllerImpl(
      useCase: Get.find()
    ));
    Get.put<CompanyController>(CompanyControllerImpl(
      getLoggedUserUseCase: Get.find()
    ));
  }
}
