import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/fetch_inventory_counting_sessions_options_use_case.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/register_inventory_counting_session_allocation_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';
import 'package:beep/shared/model/beep_inventory_session.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:get/get.dart';
import 'package:beep/core/constants/texts.dart';

abstract class InventoryCountingSessionsController extends GetxController {
  void initialize(BeepInventorySession beepInventorySession);
  String getInventoryTitle();
  void fetchInventoryCountingSessionsOptions();
  void registerAllocation(String employeeEmail, String location);
  List<InventoryEmployee> getInventoryEmployees();
  List<String> getInventoryLocations();
}

class InventoryCountingSessionsControllerImpl extends InventoryCountingSessionsController {
  final AppRouter router;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final FetchInventoryCountingSessionsOptionsUseCase fetchInventoryCountingSessionsOptionsUseCase;
  final RegisterInventoryCountingSessionAllocationUseCase registerInventoryCountingSessionAllocationUseCase;

  BeepInventoryCountingSessionsOptions beepInventoryCountingSessionsOptions;
  BeepInventorySession beepInventorySession;

  InventoryCountingSessionsControllerImpl(
      {this.loadingProvider,
      this.router,
      this.feedbackMessageProvider,
      this.fetchInventoryCountingSessionsOptionsUseCase,
      this.registerInventoryCountingSessionAllocationUseCase});

  @override
  void initialize(BeepInventorySession beepInventorySession) {
    this.beepInventorySession = beepInventorySession;
  }

  @override
  void fetchInventoryCountingSessionsOptions() async {
    loadingProvider.showFullscreenLoading();

    final inventoryCountingSessionsOptionsResult = await fetchInventoryCountingSessionsOptionsUseCase(
        FetchInventoryCountingSessionsOptionsParams(inventoryCode: beepInventorySession.beepInventory.id));

    loadingProvider.hideFullscreenLoading();
    inventoryCountingSessionsOptionsResult.fold(_handleFailure, (sessionsOptions) {
      this.beepInventoryCountingSessionsOptions = sessionsOptions;
    });
  }

  @override
  void registerAllocation(String employeeEmail, String location) async {
    loadingProvider.showFullscreenLoading();

    final allocationResult = await registerInventoryCountingSessionAllocationUseCase(
        RegisterInventoryCountingSessionAllocationParams(
            inventoryCode: beepInventorySession.beepInventory.id,
            session: beepInventorySession.session,
            inventoryCountingSessionAllocation:
                InventoryCountingSessionAllocation(
                  employee: beepInventoryCountingSessionsOptions.employees.firstWhere(
                    (element) => element.email == employeeEmail), location: location)
                  )
                );

    loadingProvider.hideFullscreenLoading();
    if (allocationResult != null) {
      allocationResult.fold(_handleFailure, null);
      return;
    }
    router.back();
    feedbackMessageProvider.showOneButtonDialog(allocationCreatedSuccessfulyTitle, allocationCreatedSuccessfulyMessage);
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  String getInventoryTitle() {
    return beepInventorySession.beepInventory.name;
  }

  @override
  List<InventoryEmployee> getInventoryEmployees() {
    return beepInventoryCountingSessionsOptions.employees;
  }

  @override
  List<String> getInventoryLocations() {
    return beepInventoryCountingSessionsOptions.locations;
  }
}
