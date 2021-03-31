import 'package:beep/features/importinventoryproducts/domain/controller/import_inventory_products_controller.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/get_available_google_drive_files_use_case.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/import_inventory_products_use_case.dart';
import 'package:beep/shared/datasource/importinventoryproducts/google_drive_files_remote_data_source.dart';
import 'package:beep/shared/datasource/importinventoryproducts/login_to_google_account_remote_data_source.dart';
import 'package:beep/shared/repository/importinventoryproducts/get_available_google_drive_files_repository.dart';
import 'package:get/get.dart';

class ImportInventoryProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleDriveFilesRemoteDataSource>(GoogleDriveFilesRemoteDataSourceImpl());
    Get.put<LoginToGoogleAccountRemoteDataSource>(LoginToGoogleAccountRemoteDataSourceImpl());
    Get.put<GetAvailableGoogleDriveFilesRepository>(GetAvailableGoogleDriveFilesRepositoryImpl(
      networkInfo: Get.find(),
      googleDriveFilesRemoteDataSource: Get.find(),
      loginToGoogleAccountRemoteDataSource: Get.find()
    ));
    Get.put<GetAvailableGoogleDriveFilesUseCase>(GetAvailableGoogleDriveFilesUseCase(
      repository: Get.find()
    ));
    Get.put<ImportInventoryProductsUseCase>(ImportInventoryProductsUseCase(
      repository: Get.find()
    ));
    Get.put<ImportInventoryProductsController>(ImportInventoryProductsControllerImpl(
      loadingProvider: Get.find(),
      feedbackMessageProvider: Get.find(),
      getAvailableGoogleDriveFilesUseCase: Get.find(),
      router: Get.find(),
      importInventoryProductsUseCase: Get.find()
    ));
  }
}
