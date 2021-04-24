import 'package:beep/features/inventoryemployees/domain/controller/inventory_employees_controller.dart';
import 'package:beep/features/inventoryemployees/domain/usecase/fetch_inventory_employees_use_case.dart';
import 'package:beep/features/inventoryemployees/domain/usecase/register_inventory_employee_use_case.dart';
import 'package:beep/shared/datasource/inventoryemployees/fetch_inventory_emoloyees_remote_data_source.dart';
import 'package:beep/shared/datasource/inventoryemployees/register_inventory_employee_remote_data_source.dart';
import 'package:beep/shared/repository/inventoryemployees/fetch_inventory_employees_repository.dart';
import 'package:beep/shared/repository/inventoryemployees/register_inventory_employee_repository.dart';
import 'package:get/get.dart';

class RegisterInventoryEmployeeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FetchInventoryEmployeesRemoteDataSource>(() =>
        FetchInventoryEmployeesRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<RegisterInventoryEmployeeRemoteDataSource>(() =>
        RegisterInventoryEmployeeRemoteDataSourceImpl(
            beepInventoryRepository: Get.find()));
    Get.lazyPut<RegisterInventoryEmployeeRepository>(() =>
        RegisterInventoryEmployeeRepositoryImpl(
            userLocalDataSource: Get.find(),
            networkInfo: Get.find(),
            registerInventoryEmployeeRemoteDataSource: Get.find()));
    Get.lazyPut<FetchInventoryEmployeesRepository>(() => FetchInventoryEmployeesRepositoryImpl(
      networkInfo: Get.find(),
      userLocalDataSource: Get.find(),
      fetchInventoryEmployeesRemoteDataSource: Get.find()
    ));
    Get.lazyPut<RegisterInventoryEmployeeUseCase>(
        () => RegisterInventoryEmployeeUseCase(repository: Get.find()));
    Get.lazyPut<FetchInventoryEmployeesUseCase>(() => FetchInventoryEmployeesUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<InventoryEmployeesController>(() =>
        InventoryEmployeesControllerImpl(
          loadingProvider: Get.find(),
          feedbackMessageProvider: Get.find(),
          registerInventoryEmployeeUseCase: Get.find(),
          fetchInventoryEmployeesUseCase: Get.find(),
          router: Get.find()
        ));
  }
}
