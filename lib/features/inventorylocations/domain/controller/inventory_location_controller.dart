import 'package:beep/core/error/failure.dart';
import 'package:beep/features/inventorylocations/domain/usecase/fetch_inventory_locations_use_case.dart';
import 'package:beep/features/inventorylocations/domain/usecase/register_inventory_location_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:get/get.dart';

abstract class InventoryLocationController extends GetxController {
  void initialize(BeepInventory beepInventory);
  void registerInventoryLocation(String name, String description);
  void fetchInventoryLocations();
  String getBeepInventoryTitle();
  List<InventoryLocation> getInventoryLocations();
  bool isCreatingInventoryLocation();
  void toogleIsCreatingInventoryLocation();
}

class InventoryLocationControllerImpl extends InventoryLocationController {
  final RegisterInventoryLocationUseCase registerInventoryLocationUseCase;
  final FetchInventoryLocationsUseCase fetchInventoryLocationsUseCase;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;

  BeepInventory _beepInventory;
  List<InventoryLocation> _inventoryLocations = [];
  bool _isCreatingInventoryLocation = false;

  InventoryLocationControllerImpl(
      {this.registerInventoryLocationUseCase,
      this.feedbackMessageProvider,
      this.loadingProvider,
      this.fetchInventoryLocationsUseCase});

  @override
  void initialize(BeepInventory beepInventory) {
    this._beepInventory = beepInventory;
  }

  @override
  void registerInventoryLocation(String name, String description) async {
    loadingProvider.showFullscreenLoading();

    final registerResult = await registerInventoryLocationUseCase(
        RegisterInventoryLocationParams(inventoryCode: _beepInventory.id, name: name, description: description));

    loadingProvider.hideFullscreenLoading();
    if (registerResult != null) {
      registerResult.fold(_handleFailure, null);
      return;
    }

    toogleIsCreatingInventoryLocation();
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  String getBeepInventoryTitle() {
    return _beepInventory.name;
  }

  @override
  bool isCreatingInventoryLocation() {
    return _isCreatingInventoryLocation;
  }

  @override
  void toogleIsCreatingInventoryLocation() {
    _isCreatingInventoryLocation = !_isCreatingInventoryLocation;
    update();
  }

  @override
  void fetchInventoryLocations() async {
    loadingProvider.showFullscreenLoading();

    final fetchInventoryLocationsResult =
        await fetchInventoryLocationsUseCase(FetchInventoryParams(inventoryCode: _beepInventory.id));

    loadingProvider.hideFullscreenLoading();
    fetchInventoryLocationsResult.fold(_handleFailure, _handleInventoryLocationsResult);
  }

  void _handleInventoryLocationsResult(List<InventoryLocation> inventoryLocations) {
    _inventoryLocations = inventoryLocations;
    update();
  }

  @override
  List<InventoryLocation> getInventoryLocations() {
    return _inventoryLocations;
  }
}
