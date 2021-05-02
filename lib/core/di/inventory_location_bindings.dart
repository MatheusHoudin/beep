import 'package:beep/features/location/domain/controller/inventory_location_controller.dart';
import 'package:beep/features/location/domain/usecase/register_inventory_location_use_case.dart';
import 'package:beep/shared/datasource/inventorylocations/register_inventory_location_remote_data_source.dart';
import 'package:beep/shared/repository/locations/register_inventory_location_repository.dart';
import 'package:get/get.dart';

class InventoryLocationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInventoryLocationRemoteDataSource>(
        () => RegisterInventoryLocationRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<RegisterInventoryLocationRepository>(() => RegisterInventoryLocationRepositoryImpl(
        networkInfo: Get.find(), remoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<RegisterInventoryLocationUseCase>(() => RegisterInventoryLocationUseCase(repository: Get.find()));
    Get.lazyPut<InventoryLocationController>(() => InventoryLocationControllerImpl(
      feedbackMessageProvider: Get.find(),
      loadingProvider: Get.find(),
      useCase: Get.find()
    ));
  }
}
