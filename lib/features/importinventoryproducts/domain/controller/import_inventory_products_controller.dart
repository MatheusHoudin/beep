import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/get_available_google_drive_files_use_case.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/import_inventory_products_use_case.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/register_inventory_products_use_case.dart';
import 'package:beep/features/importinventoryproducts/presentation/widgets/select_products_inventory_file_dialog.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/model/inventory_file.dart';
import 'package:get/get.dart';

abstract class ImportInventoryProductsController extends GetxController {
  void initialize(BeepInventory beepInventory, Function onBackPressedCallback);
  void fetchAvailableFilesToImport();
  void importInventoryProducts(String fileId);
  void registerInventoryProducts();
  String getInventoryName();
  RxList<InventoryProduct> getImportedInventoryProducts();
}

class ImportInventoryProductsControllerImpl extends ImportInventoryProductsController {
  final AppRouter router;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final GetAvailableGoogleDriveFilesUseCase getAvailableGoogleDriveFilesUseCase;
  final ImportInventoryProductsUseCase importInventoryProductsUseCase;
  final RegisterInventoryProductsUseCase registerInventoryProductsUseCase;

  RxList<InventoryProduct> _importedInventoryProducts = <InventoryProduct>[].obs;
  BeepInventory beepInventory;
  Function onBackPressedCallback;

  ImportInventoryProductsControllerImpl({
    this.loadingProvider,
    this.getAvailableGoogleDriveFilesUseCase,
    this.importInventoryProductsUseCase,
    this.feedbackMessageProvider,
    this.router,
    this.registerInventoryProductsUseCase
  });

  @override
  void initialize(BeepInventory beepInventory, Function onBackPressedCallback) {
    this.beepInventory = beepInventory;
    this.onBackPressedCallback = onBackPressedCallback;
  }

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
  void registerInventoryProducts() async {
    loadingProvider.showFullscreenLoading();

    final registerInventoryProductsOrFailure = await registerInventoryProductsUseCase(
        RegisterInventoryProductsParams(
          inventoryProducts: _importedInventoryProducts,
          inventoryCode: beepInventory.id
        )
    );

    loadingProvider.hideFullscreenLoading();
    if (registerInventoryProductsOrFailure != null) {
      registerInventoryProductsOrFailure.fold(_handleRegisterInventoryProductsFailure, null);
    } else {
      feedbackMessageProvider.showOneButtonDialog(
        importProductsSuccessTitle,
        importProductsSuccessMessage
      );
      _importedInventoryProducts.clear();
    }
  }

  void _handleRegisterInventoryProductsFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  RxList<InventoryProduct> getImportedInventoryProducts() {
    return _importedInventoryProducts;
  }

  @override
  String getInventoryName() {
    return beepInventory.name;
  }
}
