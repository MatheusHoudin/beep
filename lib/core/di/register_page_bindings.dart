import 'package:beep/features/register/domain/controller/register_controller.dart';
import 'package:beep/features/register/domain/usecase/register_use_case.dart';
import 'package:beep/shared/datasource/register/register_remote_data_source.dart';
import 'package:beep/shared/repository/register/register_repository.dart';
import 'package:get/get.dart';

class RegisterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterRemoteDataSource>(RegisterRemoteDataSourceImpl(
      authRepository: Get.find(),
      beepUserRepository: Get.find()
    ));
    Get.put<RegisterRepository>(RegisterRepositoryImpl(
      remoteDataSource: Get.find(),
      networkInfo: Get.find()
    ));
    Get.put<RegisterUseCase>(RegisterUseCase(repository: Get.find()));
    Get.put<RegisterController>(RegisterControllerImpl(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find()
    ));
  }
}
