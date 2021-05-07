import 'package:beep/features/inventorylocations/domain/controller/inventory_location_controller.dart';
import 'package:beep/features/inventorylocations/domain/usecase/fetch_inventory_locations_use_case.dart';
import 'package:beep/features/inventorylocations/domain/usecase/register_inventory_location_use_case.dart';
import 'package:beep/shared/datasource/inventorylocations/fetch_inventory_locations_remote_data_source.dart';
import 'package:beep/shared/datasource/inventorylocations/register_inventory_location_remote_data_source.dart';
import 'package:beep/shared/repository/inventorylocations/fetch_inventory_locations_repository.dart';
import 'package:beep/shared/repository/inventorylocations/register_inventory_location_repository.dart';
import 'package:get/get.dart';

class InventoryLocationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInventoryLocationRemoteDataSource>(
        () => RegisterInventoryLocationRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchInventoryLocationsRemoteDataSource>(
        () => FetchInventoryLocationsRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<RegisterInventoryLocationRepository>(() => RegisterInventoryLocationRepositoryImpl(
        networkInfo: Get.find(), remoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<FetchInventoryLocationsRepository>(() => FetchInventoryLocationsRepositoryImpl(
        networkInfo: Get.find(), remoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<RegisterInventoryLocationUseCase>(() => RegisterInventoryLocationUseCase(repository: Get.find()));
    Get.lazyPut<FetchInventoryLocationsUseCase>(() => FetchInventoryLocationsUseCase(repository: Get.find()));
    Get.lazyPut<InventoryLocationController>(() => InventoryLocationControllerImpl(
        feedbackMessageProvider: Get.find(), loadingProvider: Get.find(), fetchInventoryLocationsUseCase: Get.find(), registerInventoryLocationUseCase: Get.find()));
  }
}
