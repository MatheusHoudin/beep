import 'package:beep/features/inventorycountingsessions/domain/controller/inventory_counting_sessions_controller.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/fetch_inventory_counting_sessions_options_use_case.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/fetch_inventory_counting_sessions_options_remote_data_source.dart';
import 'package:beep/shared/repository/inventorycountingsessions/fetch_inventory_counting_sessions_options_repository.dart';
import 'package:get/get.dart';

class InventoryCountingSessionsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FetchInventoryCountingSessionsOptionsRemoteDataSource>(
        () => FetchInventoryCountingSessionsOptionsRemoteDataSourceImpl(beepInventoryRepository: Get.find()));
    Get.lazyPut<FetchInventoryCountingSessionsOptionsRepository>(() =>
        FetchInventoryCountingSessionsOptionsRepositoryImpl(
            fetchInventoryCountingSessionsRemoteDataSource: Get.find(),
            networkInfo: Get.find(),
            userLocalDataSource: Get.find()));
    Get.lazyPut<FetchInventoryCountingSessionsOptionsUseCase>(
        () => FetchInventoryCountingSessionsOptionsUseCase(repository: Get.find()));
    Get.lazyPut<InventoryCountingSessionsController>(() => InventoryCountingSessionsControllerImpl(
        feedbackMessageProvider: Get.find(),
        fetchInventoryCountingSessionsOptionsUseCase: Get.find(),
        loadingProvider: Get.find()));
  }
}
