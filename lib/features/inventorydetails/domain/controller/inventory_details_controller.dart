import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_details_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:get/get.dart';

abstract class InventoryDetailsController extends GetxController {
  void initialize(String inventoryId);
  void routeToImportInventoryProductsPage();
  void fetchInventoryDetails();
  BeepInventory getBeepInventoryDetails();
}

class InventoryDetailsControllerImpl extends InventoryDetailsController {
  final AppRouter router;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;
  final FetchInventoryDetailsUseCase fetchInventoryDetailsUseCase;

  String inventoryId;
  BeepInventory beepInventory;

  InventoryDetailsControllerImpl({
    this.router,
    this.fetchInventoryDetailsUseCase,
    this.feedbackMessageProvider,
    this.loadingProvider
  });

  @override
  void routeToImportInventoryProductsPage() {
    router.routeInventoryDetailsPageToImportInventoryProductsPage(
      inventoryId
    );
  }

  @override
  void initialize(String inventoryId) {
    this.inventoryId = inventoryId;
  }

  @override
  void fetchInventoryDetails() async {
    final inventoryDetailsOrFailure = await fetchInventoryDetailsUseCase.call(
      FetchInventoryDetailsParams(inventoryId: inventoryId)
    );

    inventoryDetailsOrFailure.fold(
      (failure) {
        feedbackMessageProvider.showOneButtonDialog(
          failure.title,
          failure.message
        );
      },
      (inventoryDetails) {
        this.beepInventory = inventoryDetails;
        update();
      }
    );
  }

  @override
  BeepInventory getBeepInventoryDetails() {
    return this.beepInventory;
  }
}
