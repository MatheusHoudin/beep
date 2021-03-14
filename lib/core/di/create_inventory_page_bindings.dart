import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/features/createinventory/domain/controller/create_inventory_controller.dart';
import 'package:beep/features/createinventory/domain/usecase/create_inventory_use_case.dart';
import 'package:beep/shared/datasource/createinventory/create_inventory_remote_data_source.dart';
import 'package:beep/shared/repository/createinventory/create_inventory_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateInventoryPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeepInventoryRepository>(() => BeepInventoryRepositoryImpl(
      firestore: FirebaseFirestore.instance
    ));
    Get.lazyPut<CreateInventoryRemoteDataSource>(
            () => CreateInventoryRemoteDataSourceImpl(repository: Get.find()));
    Get.lazyPut<CreateInventoryRepository>(() => CreateInventoryRepositoryImpl(
      preferences: Get.find(),
      remoteDataSource: Get.find(),
      networkInfo: Get.find()
    ));
    Get.lazyPut<CreateInventoryUseCase>(() => CreateInventoryUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<CreateInventoryController>(() => CreateInventoryControllerImpl(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find()
    ));
  }
}
