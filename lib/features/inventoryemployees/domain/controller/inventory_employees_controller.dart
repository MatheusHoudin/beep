import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/inventoryemployees/domain/usecase/fetch_inventory_employees_use_case.dart';
import 'package:beep/features/inventoryemployees/domain/usecase/register_inventory_employee_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:get/get.dart';
import 'package:beep/core/constants/texts.dart';

abstract class InventoryEmployeesController extends GetxController {
  void initialize(BeepInventory inventory);

  void registerInventoryEmployee(String userEmail);

  String getInventoryName();

  List<InventoryEmployee> getInventoryEmployee();

  void fetchInventoryEmployees();
}

class InventoryEmployeesControllerImpl extends InventoryEmployeesController {
  final RegisterInventoryEmployeeUseCase registerInventoryEmployeeUseCase;
  final FetchInventoryEmployeesUseCase fetchInventoryEmployeesUseCase;
  final FeedbackMessageProvider feedbackMessageProvider;
  final AppRouter router;
  final LoadingProvider loadingProvider;

  BeepInventory _beepInventory;
  RxList<InventoryEmployee> _inventoryEmployees = RxList.empty(growable: true);

  InventoryEmployeesControllerImpl(
      {this.registerInventoryEmployeeUseCase,
      this.feedbackMessageProvider,
      this.loadingProvider,
      this.fetchInventoryEmployeesUseCase,
      this.router});

  @override
  void initialize(BeepInventory inventory) {
    this._beepInventory = inventory;
  }

  @override
  void fetchInventoryEmployees() async {
    loadingProvider.showFullscreenLoading();

    final inventoryEmployeesResult = await fetchInventoryEmployeesUseCase(
        FetchInventoryEmployeesParams(inventoryId: _beepInventory.id)
    );

    loadingProvider.hideFullscreenLoading();
    inventoryEmployeesResult.fold(
      _handleFailure,
      (inventoryEmployees) {
        _inventoryEmployees.clear();
        _inventoryEmployees.addAll(inventoryEmployees);
        update();
      }
    );
  }

  @override
  void registerInventoryEmployee(String userEmail) async {
    loadingProvider.showFullscreenLoading();

    final registerResult = await registerInventoryEmployeeUseCase(
        RegisterInventoryEmployeeParams(
            userEmail: userEmail, inventoryId: _beepInventory.id));

    loadingProvider.hideFullscreenLoading();
    registerResult.fold(_handleFailure, (_) => _handleRegisterInventoryEmployeeSuccess());
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  void _handleRegisterInventoryEmployeeSuccess() {
    feedbackMessageProvider.showOneButtonDialog(
        registerInventoryEmployeeSuccessfulTitle,
        registerInventoryEmployeeSuccessfulMessage,
        okFunction: () {
          router.back();
          fetchInventoryEmployees();
        }
    );
  }

  @override
  String getInventoryName() {
    return _beepInventory.name;
  }

  @override
  List<InventoryEmployee> getInventoryEmployee() {
    return _inventoryEmployees;
  }
}
