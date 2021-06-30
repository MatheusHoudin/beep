import 'package:beep/features/employeeinventoryallocations/domain/controller/employee_inventory_allocations_controller.dart';
import 'package:beep/features/employeeinventoryallocations/domain/usecase/change_allocation_status_use_case.dart';
import 'package:beep/features/employeeinventoryallocations/domain/usecase/fetch_employee_inventory_data_use_case.dart';
import 'package:beep/shared/datasource/changeallocationstatus/change_allocation_status_remote_data_source.dart';
import 'package:beep/shared/datasource/employeeinventoryallocations/fetch_employee_inventory_allocations_remote_data_source.dart';
import 'package:beep/shared/datasource/inventoryproducts/fetch_inventory_products_remote_data_source.dart';
import 'package:beep/shared/repository/changeallocationstatus/change_allocation_status_repository.dart';
import 'package:beep/shared/repository/employeeinventoryallocations/fetch_employee_inventory_data_repository.dart';
import 'package:get/get.dart';

class EmployeeInventoryAllocationsPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeAllocationStatusRemoteDataSource>(
        () => ChangeAllocationStatusRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchInventoryProductsRemoteDataSource>(
        () => FetchInventoryProductsRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchEmployeeInventoryAllocationsRemoteDataSource>(
        () => FetchEmployeeInventoryAllocationsRemoteDataSourceImpl(repository: Get.find()));

    Get.lazyPut<ChangeAllocationStatusRepository>(() => ChangeAllocationStatusRepositoryImpl(
        changeAllocationStatusRemoteDataSource: Get.find(), networkInfo: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<FetchEmployeeInventoryDataRepository>(() => FetchEmployeeInventoryDataRepositoryImpl(
        fetchEmployeeInventoryAllocationsRemoteDataSource: Get.find(),
        networkInfo: Get.find(),
        userLocalDataSource: Get.find(),
        fetchInventoryProductsRemoteDataSource: Get.find()));

    Get.lazyPut<ChangeAllocationStatusUseCase>(() => ChangeAllocationStatusUseCase(repository: Get.find()));
    Get.lazyPut<FetchEmployeeInventoryDataUseCase>(() => FetchEmployeeInventoryDataUseCase(repository: Get.find()));

    Get.lazyPut<EmployeeInventoryAllocationsController>(() => EmployeeInventoryAllocationsControllerImpl(
        feedbackMessageProvider: Get.find(),
        fetchEmployeeInventoryDataUseCase: Get.find(),
        loadingProvider: Get.find(),
        router: Get.find(),
        changeAllocationStatusUseCase: Get.find()));
  }
}
