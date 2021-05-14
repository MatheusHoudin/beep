import 'package:beep/core/error/failure.dart';
import 'package:beep/features/inventorycountingsessions/domain/usecase/fetch_inventory_counting_sessions_options_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';
import 'package:beep/shared/model/beep_inventory_session.dart';
import 'package:get/get.dart';

abstract class InventoryCountingSessionsController extends GetxController {
  void initialize(BeepInventorySession beepInventorySession);
  String getInventoryTitle();
  void fetchInventoryCountingSessionsOptions();
}

class InventoryCountingSessionsControllerImpl extends InventoryCountingSessionsController {
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final FetchInventoryCountingSessionsOptionsUseCase fetchInventoryCountingSessionsOptionsUseCase;

  BeepInventoryCountingSessionsOptions beepInventoryCountingSessionsOptions;
  BeepInventorySession beepInventorySession;

  InventoryCountingSessionsControllerImpl(
      {this.loadingProvider, this.feedbackMessageProvider, this.fetchInventoryCountingSessionsOptionsUseCase});

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

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  String getInventoryTitle() {
    return beepInventorySession.beepInventory.name;
  }
}
