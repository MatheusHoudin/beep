import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_details_use_case.dart';
import 'package:beep/shared/datasource/fetchinventorydetails/fetch_inventory_details_remote_data_source.dart';
import 'package:beep/shared/repository/fetchinventorydetails/fetch_inventory_details_repository.dart';
import 'package:get/get.dart';

class InventoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FetchInventoryDetailsRemoteDataSource>(FetchInventoryDetailsRemoteDataSourceImpl(
      beepInventoryRepository: Get.find()
    ));
    Get.put<FetchInventoryDetailsRepository>(FetchInventoryDetailsRepositoryImpl(
      networkInfo: Get.find(),
      fetchInventoryDetailsRemoteDataSource: Get.find(),
      userLocalDataSource: Get.find()
    ));
    Get.put<FetchInventoryDetailsUseCase>(FetchInventoryDetailsUseCase(
      repository: Get.find(),
    ));
    Get.put<InventoryDetailsController>(InventoryDetailsControllerImpl(
      router: Get.find(),
      feedbackMessageProvider: Get.find(),
      loadingProvider: Get.find(),
      fetchInventoryDetailsUseCase: Get.find()
    ));
  }
}
