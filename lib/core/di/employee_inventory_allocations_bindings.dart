import 'package:beep/features/employeeinventoryallocations/domain/controller/employee_inventory_allocations_controller.dart';
import 'package:beep/features/employeeinventoryallocations/domain/usecase/fetch_employee_inventory_allocations_use_case.dart';
import 'package:beep/shared/datasource/employeeinventoryallocations/fetch_employee_inventory_allocations_remote_data_source.dart';
import 'package:beep/shared/repository/employeeinventoryallocations/fetch_employee_inventory_allocations_repository.dart';
import 'package:get/get.dart';

class EmployeeInventoryAllocationsPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FetchEmployeeInventoryAllocationsRemoteDataSource>(
        () => FetchEmployeeInventoryAllocationsRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchEmployeeInventoryAllocationsRepository>(() => FetchEmployeeInventoryAllocationsRepositoryImpl(
        fetchEmployeeInventoryAllocationsRemoteDataSource: Get.find(),
        networkInfo: Get.find(),
        userLocalDataSource: Get.find()));
    Get.lazyPut<FetchEmployeeInventoryAllocationsUseCase>(
        () => FetchEmployeeInventoryAllocationsUseCase(repository: Get.find()));
    Get.lazyPut<EmployeeInventoryAllocationsController>(() => EmployeeInventoryAllocationsControllerImpl(
      feedbackMessageProvider: Get.find(),
      fetchEmployeeInventoryAllocationsUseCase: Get.find(),
      loadingProvider: Get.find()
    ));
  }
}
