import 'package:beep/core/error/failure.dart';
import 'package:beep/features/location/domain/usecase/register_inventory_location_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:get/get.dart';

abstract class InventoryLocationController extends GetxController {
  void initialize(String inventoryCode);
  void registerInventoryLocation(String name, String description);
}

class InventoryLocationControllerImpl extends InventoryLocationController {
  final RegisterInventoryLocationUseCase useCase;
  final FeedbackMessageProvider feedbackMessageProvider;
  final LoadingProvider loadingProvider;
  String _inventoryCode;

  InventoryLocationControllerImpl({this.useCase, this.feedbackMessageProvider, this.loadingProvider});

  @override
  void initialize(String inventoryCode) {
    this._inventoryCode = inventoryCode;
  }

  @override
  void registerInventoryLocation(String name, String description) async {
    loadingProvider.showFullscreenLoading();

    final registerResult = await useCase(
        RegisterInventoryLocationParams(inventoryCode: _inventoryCode, name: name, description: description));

    loadingProvider.hideFullscreenLoading();
    if (registerResult != null) {
      registerResult.fold(_handleFailure, null);
      return;
    }

    //TODO Recarregar lista de enderecos
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }
}
