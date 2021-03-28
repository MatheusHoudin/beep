import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/importinventoryproducts/domain/usecase/get_available_google_drive_files_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/inventory_file.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart' as ga;

abstract class ImportInventoryProductsController extends GetxController {
  void fetchAvailableFilesToImport();
}

class ImportInventoryProductsControllerImpl extends ImportInventoryProductsController {
  final AppRouter router;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final GetAvailableGoogleDriveFilesUseCase getAvailableGoogleDriveFilesUseCase;

  ImportInventoryProductsControllerImpl({
    this.loadingProvider,
    this.getAvailableGoogleDriveFilesUseCase,
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
        final inventoryFiles = availableFiles.map((file) => InventoryFile.fromDriveFile(file));

        router.routeImportInventoryProductsPageToSelectedProductsPage(inventoryFiles);
      }
    );
  }
}
