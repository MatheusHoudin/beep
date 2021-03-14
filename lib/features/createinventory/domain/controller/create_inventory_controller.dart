import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/createinventory/domain/usecase/create_inventory_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:get/get.dart';

abstract class CreateInventoryController extends GetxController {
  void createInventory(
    String name,
    String description,
    String date,
    String time
  );
}

class CreateInventoryControllerImpl extends CreateInventoryController {
  final FeedbackMessageProvider _feedbackMessageProvider;
  final LoadingProvider _loadingProvider;
  final CreateInventoryUseCase _useCase;
  final AppRouter _router;

  CreateInventoryControllerImpl([
    this._feedbackMessageProvider,
    this._loadingProvider,
    this._useCase,
    this._router
  ]);

  @override
  void createInventory(String name, String description, String date, String time) async {
    _loadingProvider.showFullscreenLoading();

    final params = CreateInventoryParams(
      name: name,
      description: description,
      date: date,
      time: time
    );

    final createInventoryResult = await _useCase.call(params);

    _loadingProvider.hideFullscreenLoading();

    if (createInventoryResult != null) {
      createInventoryResult.fold(_handleCreateInventoryFailure, null);
    } else {
      _router.back();
      _feedbackMessageProvider.showOneButtonDialog(
        createInventorySuccessTitle,
        createInventorySuccessMessage
      );
    }
  }

  void _handleCreateInventoryFailure(Failure failure) {
    _feedbackMessageProvider.showOneButtonDialog(
      failure.title,
      failure.message
    );
  }
}
