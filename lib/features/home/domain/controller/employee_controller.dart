import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/home/domain/usecase/fetch_employee_inventories_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:get/get.dart';

abstract class EmployeeController extends GetxController {
  void initialize();
  void fetchEmployeeInventories();
  void routeToInventoryAllocationsPage(int inventoryIndex);
  String getLoggedUserName();
  List<BeepInventory> getEmployeeInventories();
}

class EmployeeControllerImpl extends EmployeeController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final FetchEmployeeInventoriesUseCase fetchEmployeeInventoriesUseCase;
  final AppRouter router;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;

  BeepUser _beepUser;
  List<BeepInventory> _employeeInventories = [];

  EmployeeControllerImpl(
      {this.getLoggedUserUseCase,
      this.fetchEmployeeInventoriesUseCase,
      this.router,
      this.loadingProvider,
      this.feedbackMessageProvider});

  @override
  void initialize() {
    _beepUser = getLoggedUserUseCase(GetLoggedUserParams());
  }

  @override
  void fetchEmployeeInventories() async {
    loadingProvider.showFullscreenLoading();

    final fetchEmployeeInventoriesResult = await fetchEmployeeInventoriesUseCase(FetchEmployeeInventoriesParams());

    loadingProvider.hideFullscreenLoading();
    fetchEmployeeInventoriesResult.fold(_handleFailure, (inventories) {
      this._employeeInventories = inventories;
      update();
    });
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  String getLoggedUserName() {
    return _beepUser?.name ?? "";
  }

  @override
  List<BeepInventory> getEmployeeInventories() {
    return _employeeInventories;
  }

  @override
  void routeToInventoryAllocationsPage(int inventoryIndex) {
    router.routeHomePageToEmployeeInventoryAllocationsPage(_employeeInventories[inventoryIndex]);
  }
}
