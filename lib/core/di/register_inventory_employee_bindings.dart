import 'package:beep/features/inventoryemployees/domain/controller/register_inventory_employee_controller.dart';
import 'package:beep/features/inventoryemployees/domain/usecase/register_inventory_employee_use_case.dart';
import 'package:beep/shared/datasource/inventoryemployees/register_inventory_employee_remote_data_source.dart';
import 'package:beep/shared/repository/inventoryemployees/register_inventory_employee_repository.dart';
import 'package:get/get.dart';

class RegisterInventoryEmployeeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInventoryEmployeeRemoteDataSource>(() =>
        RegisterInventoryEmployeeRemoteDataSourceImpl(
            beepInventoryRepository: Get.find()
        )
    );
    Get.lazyPut<RegisterInventoryEmployeeRepository>(() =>
        RegisterInventoryEmployeeRepositoryImpl(
          userLocalDataSource: Get.find(),
          networkInfo: Get.find(),
          registerInventoryEmployeeRemoteDataSource: Get.find()
        )
    );
    Get.lazyPut<RegisterInventoryEmployeeUseCase>(() =>
      RegisterInventoryEmployeeUseCase(repository: Get.find())
    );
    Get.lazyPut<RegisterInventoryEmployeeController>(() =>
        RegisterInventoryEmployeeControllerImpl(
          loadingProvider: Get.find(),
          feedbackMessageProvider: Get.find(),
          registerInventoryEmployeeUseCase: Get.find()
        )
    );
  }
}
