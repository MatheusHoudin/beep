import 'package:beep/features/login/domain/controller/login_page_controller.dart';
import 'package:beep/features/login/domain/usecase/login_use_case.dart';
import 'package:beep/shared/datasource/login/login_remote_data_source.dart';
import 'package:beep/shared/repository/login/login_repository.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(
      beepUserRepository: Get.find(),
      authRepository: Get.find()
    ));
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(
      networkInfo: Get.find(),
      remoteDataSource: Get.find(),
      preferences: Get.find()
    ));
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(
      loginRepository: Get.find()
    ));
    Get.lazyPut<LoginPageController>(() => LoginPageControllerImpl(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find()
    ));
  }
}
