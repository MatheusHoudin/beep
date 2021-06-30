import 'package:beep/features/registercounting/domain/controller/register_counting_controller.dart';
import 'package:beep/features/registercounting/domain/usecase/register_counting_use_case.dart';
import 'package:beep/shared/datasource/registercounting/register_counting_remote_data_source.dart';
import 'package:beep/shared/repository/registercounting/register_counting_repository.dart';
import 'package:get/get.dart';

class RegisterCountingPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterCountingRemoteDataSource>(() => RegisterCountingRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<RegisterCountingRepository>(() => RegisterCountingRepositoryImpl(
        networkInfo: Get.find(), registerCountingRemoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<RegisterCountingUseCase>(() => RegisterCountingUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<RegisterCountingController>(() => RegisterCountingControllerImpl(
      getLoggedUserUseCase: Get.find(),
      feedbackMessageProvider: Get.find(),
      loadingProvider: Get.find(),
      registerCountingUseCase: Get.find(),
      changeAllocationStatusUseCase: Get.find(),
      router: Get.find()
    ));
  }
}
