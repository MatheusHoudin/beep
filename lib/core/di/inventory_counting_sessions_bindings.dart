import 'package:beep/features/inventorycountingsessions/domain/controller/inventory_counting_sessions_controller.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/fetch_inventory_counting_session_allocations_use_case.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/fetch_inventory_counting_sessions_options_use_case.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/register_inventory_counting_session_allocation_use_case.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/fetch_inventory_counting_session_allocations_remote_data_source.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/fetch_inventory_counting_sessions_options_remote_data_source.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/register_inventory_counting_session_allocation_remote_data_source.dart';
import 'package:beep/shared/repository/inventorycountingsessions/fetch_inventory_counting_session_allocations_repository.dart';
import 'package:beep/shared/repository/inventorycountingsessions/fetch_inventory_counting_sessions_options_repository.dart';
import 'package:beep/shared/repository/inventorycountingsessions/register_inventory_counting_session_allocation_repository.dart';
import 'package:get/get.dart';

class InventoryCountingSessionsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FetchInventoryCountingSessionAllocationsRemoteDataSource>(
        () => FetchInventoryCountingSessionAllocationsRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<FetchInventoryCountingSessionsOptionsRemoteDataSource>(
        () => FetchInventoryCountingSessionsOptionsRemoteDataSourceImpl(beepInventoryRepository: Get.find()));
    Get.lazyPut<RegisterInventoryCountingSessionAllocationRemoteDataSource>(
        () => RegisterInventoryCountingSessionAllocationRemoteDataSourceImpl(repository: Get.find()));

    Get.lazyPut<FetchInventoryCountingSessionAllocationsRepository>(() =>
        FetchInventoryCountingSessionAllocationsRepositoryImpl(
            fetchInventoryCountingSessionAllocationsRemoteDataSource: Get.find(),
            networkInfo: Get.find(),
            userLocalDataSource: Get.find()));
    Get.lazyPut<FetchInventoryCountingSessionsOptionsRepository>(() =>
        FetchInventoryCountingSessionsOptionsRepositoryImpl(
            fetchInventoryCountingSessionsRemoteDataSource: Get.find(),
            networkInfo: Get.find(),
            userLocalDataSource: Get.find()));
    Get.lazyPut<RegisterInventoryCountingSessionAllocationRepository>(() =>
        RegisterInventoryCountingSessionAllocationRepositoryImpl(
            allocationRemoteDataSource: Get.find(), networkInfo: Get.find(), userLocalDataSource: Get.find()));

    Get.lazyPut<FetchInventoryCountingSessionAllocationsUseCase>(
        () => FetchInventoryCountingSessionAllocationsUseCase(repository: Get.find()));
    Get.lazyPut<FetchInventoryCountingSessionsOptionsUseCase>(
        () => FetchInventoryCountingSessionsOptionsUseCase(repository: Get.find()));
    Get.lazyPut<RegisterInventoryCountingSessionAllocationUseCase>(
        () => RegisterInventoryCountingSessionAllocationUseCase(repository: Get.find()));

    Get.lazyPut<InventoryCountingSessionsController>(() => InventoryCountingSessionsControllerImpl(
        feedbackMessageProvider: Get.find(),
        fetchInventoryCountingSessionsOptionsUseCase: Get.find(),
        loadingProvider: Get.find(),
        registerInventoryCountingSessionAllocationUseCase: Get.find(),
        router: Get.find(),
        fetchInventoryCountingSessionAllocationsUseCase: Get.find()));
  }
}
