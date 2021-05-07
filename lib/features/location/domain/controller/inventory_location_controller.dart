import 'package:beep/core/error/failure.dart';
import 'package:beep/features/location/domain/usecase/register_inventory_location_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:get/get.dart';

abstract class InventoryLocationController extends GetxController {
  void initialize(BeepInventory beepInventory);
  void registerInventoryLocation(String name, String description);
  String getBeepInventoryTitle();
  bool isCreatingInventoryLocation();
  void toogleIsCreatingInventoryLocation();
}

class InventoryLocationControllerImpl extends InventoryLocationController {
  final RegisterInventoryLocationUseCase useCase;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;

  BeepInventory _beepInventory;
  bool _isCreatingInventoryLocation = false;

  InventoryLocationControllerImpl({this.useCase, this.feedbackMessageProvider, this.loadingProvider});

  @override
  void initialize(BeepInventory beepInventory) {
    this._beepInventory = beepInventory;
  }

  @override
  void registerInventoryLocation(String name, String description) async {
    loadingProvider.showFullscreenLoading();

    final registerResult = await useCase(
        RegisterInventoryLocationParams(inventoryCode: _beepInventory.id, name: name, description: description));

    loadingProvider.hideFullscreenLoading();
    if (registerResult != null) {
      registerResult.fold(_handleFailure, null);
      return;
    }

    toogleIsCreatingInventoryLocation();
    //TODO Recarregar lista de enderecos
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
}
