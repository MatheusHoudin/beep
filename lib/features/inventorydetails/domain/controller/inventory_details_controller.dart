import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_details_use_case.dart';
import 'package:beep/features/inventorydetails/domain/usecase/fetch_inventory_sessions_use_case.dart';
import 'package:beep/features/inventorydetails/domain/usecase/register_inventory_session_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:get/get.dart';

abstract class InventoryDetailsController extends GetxController {
  void initialize(String inventoryId);
  void routeToInventoryCountingSessions(String selectedSession);
  void routeToImportInventoryProductsPage();
  void routeToInventoryEmployeesPage();
  void routeToInventoryLocationsPage();
  void fetchInventoryDetails();
  void fetchInventorySessions();
  void registerInventorySession(String name, String type);
  BeepInventory getBeepInventoryDetails();
  List<InventoryCountingSession> getInventorySessions();
}

class InventoryDetailsControllerImpl extends InventoryDetailsController {
  final AppRouter router;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;
  final FetchInventoryDetailsUseCase fetchInventoryDetailsUseCase;
  final FetchInventorySessionsUseCase fetchInventorySessionsUseCase;
  final RegisterInventorySessionUseCase registerInventorySessionUseCase;

  String inventoryId;
  BeepInventory beepInventory;
  List<InventoryCountingSession> inventoryCountingSessions = [];

  InventoryDetailsControllerImpl(
      {this.router,
      this.fetchInventoryDetailsUseCase,
      this.feedbackMessageProvider,
      this.loadingProvider,
      this.registerInventorySessionUseCase,
      this.fetchInventorySessionsUseCase});

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
      fetchInventorySessions();
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
    fetchInventorySessions();
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  BeepInventory getBeepInventoryDetails() {
    return this.beepInventory;
  }

  @override
  void fetchInventorySessions() async {
    loadingProvider.showFullscreenLoading();

    final fetchInventorySessionsResult =
        await fetchInventorySessionsUseCase(FetchInventorySessionsParams(inventoryCode: beepInventory.id));

    loadingProvider.hideFullscreenLoading();
    fetchInventorySessionsResult.fold(_handleFailure, (inventorySessions) {
      this.inventoryCountingSessions = inventorySessions;
      update();
    });
  }

  @override
  List<InventoryCountingSession> getInventorySessions() {
    return inventoryCountingSessions;
  }

  @override
  void routeToInventoryCountingSessions(String selectedSession) {
    router.routeInventoryDetailsPageToInventoryCountingSessionsPage(beepInventory, selectedSession);
  }
}
