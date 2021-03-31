import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/get_available_google_drive_files_use_case.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/import_inventory_products_use_case.dart';
import 'package:beep/features/importinventoryproducts/presentation/widgets/select_products_inventory_file_dialog.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/imported_inventory_product.dart';
import 'package:beep/shared/model/inventory_file.dart';
import 'package:get/get.dart';

abstract class ImportInventoryProductsController extends GetxController {
  void fetchAvailableFilesToImport();
  void importInventoryProducts(String fileId);
  RxList<ImportedInventoryProduct> getImportedInventoryProducts();
}

class ImportInventoryProductsControllerImpl extends ImportInventoryProductsController {
  final AppRouter router;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final GetAvailableGoogleDriveFilesUseCase getAvailableGoogleDriveFilesUseCase;
  final ImportInventoryProductsUseCase importInventoryProductsUseCase;

  RxList<ImportedInventoryProduct> _importedInventoryProducts = <ImportedInventoryProduct>[].obs;

  ImportInventoryProductsControllerImpl({
    this.loadingProvider,
    this.getAvailableGoogleDriveFilesUseCase,
    this.importInventoryProductsUseCase,
    this.feedbackMessageProvider,
    this.router
  });

  @override
  void fetchAvailableFilesToImport() async {
    final result = await getAvailableGoogleDriveFilesUseCase.call(GetAvailableGoogleDriveFilesParams());

    result.fold(
      (failure) {
        feedbackMessageProvider.showOneButtonDialog(
          failure.title,
          failure.message
        );
      },
      (availableFiles) {
        final inventoryFiles = availableFiles.map((file) => InventoryFile.fromDriveFile(file)).toList();

        Get.dialog(SelectProductsInventoryFileDialog(inventoryFiles: inventoryFiles,));
      }
    );
  }

  @override
  void importInventoryProducts(String fileId) async {
    router.back();
    router.back();
    loadingProvider.showFullscreenLoading();

    final inventoryProductsOrFailure = await importInventoryProductsUseCase.call(ImportInventoryProductsParams(fileId: fileId));

    loadingProvider.hideFullscreenLoading();
    inventoryProductsOrFailure.fold(
      (failure) {
        feedbackMessageProvider.showOneButtonDialog(
          failure.title,
          failure.message
        );
      },
      (inventoryProducts) {
        _importedInventoryProducts.addAll(inventoryProducts);
      }
    );
  }

  @override
  RxList<ImportedInventoryProduct> getImportedInventoryProducts() {
    return _importedInventoryProducts;
  }
}
