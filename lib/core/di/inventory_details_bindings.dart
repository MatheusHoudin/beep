import 'package:beep/features/inventorydetails/domain/controller/inventory_details_controller.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_details_use_case.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_sessions_use_case.dart';
import 'package:beep/features/inventorydetails/domain/usecase/register_inventory_session_use_case.dart';
import 'package:beep/shared/datasource/fetchinventorydetails/fetch_inventory_details_remote_data_source.dart';
import 'package:beep/shared/datasource/inventorysessions/fetch_inventory_sessions_remote_data_source.dart';
import 'package:beep/shared/datasource/inventorysessions/register_inventory_session_remote_data_source.dart';
import 'package:beep/shared/repository/fetchinventorydetails/fetch_inventory_details_repository.dart';
import 'package:beep/shared/repository/inventorysessions/fetch_inventory_sessions_repository.dart';
import 'package:beep/shared/repository/inventorysessions/register_inventory_session_repository.dart';
import 'package:get/get.dart';

class InventoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInventorySessionRemoteDataSource>(
        () => RegisterInventorySessionRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchInventorySessionsRemoteDataSource>(
        () => FetchInventorySessionsRemoteDataSourceImpl(repository: Get.find()));
    Get.put<FetchInventoryDetailsRemoteDataSource>(
        FetchInventoryDetailsRemoteDataSourceImpl(beepInventoryRepository: Get.find()));
    Get.lazyPut<RegisterInventorySessionRepository>(() => RegisterInventorySessionRepositoryImpl(
        networkInfo: Get.find(), remoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.put<FetchInventoryDetailsRepository>(FetchInventoryDetailsRepositoryImpl(
        networkInfo: Get.find(), fetchInventoryDetailsRemoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.lazyPut<FetchInventorySessionsRepository>(() => FetchInventorySessionsRepositoryImpl(
        fetchInventorySessionsRemoteDataSource: Get.find(), userLocalDataSource: Get.find()));
    Get.put<FetchInventoryDetailsUseCase>(FetchInventoryDetailsUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<RegisterInventorySessionUseCase>(() => RegisterInventorySessionUseCase(repository: Get.find()));
    Get.lazyPut<FetchInventorySessionsUseCase>(() => FetchInventorySessionsUseCase(repository: Get.find()));
    Get.put<InventoryDetailsController>(
      InventoryDetailsControllerImpl(
          router: Get.find(),
          registerInventorySessionUseCase: Get.find(),
          feedbackMessageProvider: Get.find(),
          loadingProvider: Get.find(),
          fetchInventoryDetailsUseCase: Get.find(),
          fetchInventorySessionsUseCase: Get.find()),
    );
  }
}
