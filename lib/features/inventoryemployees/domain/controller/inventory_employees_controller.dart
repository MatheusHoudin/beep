import 'package:beep/core/error/failure.dart';
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
  final LoadingProvider loadingProvider;

  BeepInventory _beepInventory;
  RxList<InventoryEmployee> _inventoryEmployees = RxList.empty(growable: true);

  InventoryEmployeesControllerImpl(
      {this.registerInventoryEmployeeUseCase,
      this.feedbackMessageProvider,
      this.loadingProvider,
      this.fetchInventoryEmployeesUseCase});

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
      _handleFailureFailure,
      (inventoryEmployees) {
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
    if (registerResult != null) {
      registerResult.fold(_handleFailureFailure, null);
    } else {
      feedbackMessageProvider.showOneButtonDialog(
          registerInventoryEmployeeSuccessfulTitle,
          registerInventoryEmployeeSuccessfulMessage);
    }
  }

  void _handleFailureFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
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
