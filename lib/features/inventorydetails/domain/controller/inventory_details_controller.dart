import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_details_use_case.dart';
import 'package:beep/features/inventorydetails/domain/usecase/register_inventory_session_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:get/get.dart';

abstract class InventoryDetailsController extends GetxController {
  void initialize(String inventoryId);
  void routeToImportInventoryProductsPage();
  void routeToInventoryEmployeesPage();
  void routeToInventoryLocationsPage();
  void fetchInventoryDetails();
  void registerInventorySession(String name, String type);
  BeepInventory getBeepInventoryDetails();
}

class InventoryDetailsControllerImpl extends InventoryDetailsController {
  final AppRouter router;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;
  final FetchInventoryDetailsUseCase fetchInventoryDetailsUseCase;
  final RegisterInventorySessionUseCase registerInventorySessionUseCase;

  String inventoryId;
  BeepInventory beepInventory;

  InventoryDetailsControllerImpl(
      {this.router,
      this.fetchInventoryDetailsUseCase,
      this.feedbackMessageProvider,
      this.loadingProvider,
      this.registerInventorySessionUseCase});

  @override
  void routeToImportInventoryProductsPage() {
    router.routeInventoryDetailsPageToImportInventoryProductsPage(beepInventory);
  }

  @override
  void routeToInventoryEmployeesPage() {
    router.routeInventoryDetailsPageToInventoryEmployeesPage(beepInventory);
  }

  @override
  void routeToInventoryLocationsPage() {
    router.routeInventoryDetailsPageToInventoryLocationsPage(beepInventory);
  }

  @override
  void initialize(String inventoryId) {
    this.inventoryId = inventoryId;
  }

  @override
  void fetchInventoryDetails() async {
    loadingProvider.showFullscreenLoading();

    final inventoryDetailsOrFailure =
        await fetchInventoryDetailsUseCase.call(FetchInventoryDetailsParams(inventoryId: inventoryId));

    loadingProvider.hideFullscreenLoading();
    inventoryDetailsOrFailure.fold(_handleFailure, (inventoryDetails) {
      this.beepInventory = inventoryDetails;
      update();
    });
  }

  @override
  void registerInventorySession(String name, String type) async {
    loadingProvider.showFullscreenLoading();

    final registerInventorySessionResult = await registerInventorySessionUseCase(
        RegisterInventorySessionParams(inventoryCode: beepInventory.id, name: name, type: type));

    loadingProvider.hideFullscreenLoading();
    if (registerInventorySessionResult != null) {
      registerInventorySessionResult.fold(_handleFailure, null);
      return;
    }

    router.back();
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  BeepInventory getBeepInventoryDetails() {
    return this.beepInventory;
  }
}
