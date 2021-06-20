import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/employeeinventoryallocations/domain/usecase/fetch_employee_inventory_data_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:get/get.dart';

abstract class EmployeeInventoryAllocationsController extends GetxController {
  void initialize(BeepInventory beepInventory);
  void fetchEmployeeInventoryData();
  void routeToRegisterCounting(EmployeeInventoryAllocation allocation);
  List<EmployeeInventoryAllocation> getEmployeeInventoryAllocations();
}

class EmployeeInventoryAllocationsControllerImpl extends EmployeeInventoryAllocationsController {
  final FetchEmployeeInventoryDataUseCase fetchEmployeeInventoryDataUseCase;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;
  final AppRouter router;

  List<EmployeeInventoryAllocation> _employeeInventoryAllocations = [];
  List<InventoryProduct> _products = [];
  BeepInventory _beepInventory;

  EmployeeInventoryAllocationsControllerImpl(
      {this.fetchEmployeeInventoryDataUseCase, this.loadingProvider, this.feedbackMessageProvider, this.router});

  @override
  void initialize(BeepInventory beepInventory) {
    this._beepInventory = beepInventory;
  }

  @override
  void fetchEmployeeInventoryData() async {
    loadingProvider.showFullscreenLoading();

    final employeeInventoryDataResult =
        await fetchEmployeeInventoryDataUseCase(FetchEmployeeInventoryDataParams(inventoryCode: _beepInventory.id));

    loadingProvider.hideFullscreenLoading();

    employeeInventoryDataResult.fold(_handleFailure, (employeeInventoryData) {
      _employeeInventoryAllocations = employeeInventoryData.allocations;
      _products = employeeInventoryData.products;
      print(_products);
      update();
    });
  }

  void _handleFailure(Failure failure) {
    feedbackMessageProvider.showOneButtonDialog(failure.title, failure.message);
  }

  @override
  List<EmployeeInventoryAllocation> getEmployeeInventoryAllocations() {
    return _employeeInventoryAllocations;
  }

  @override
  void routeToRegisterCounting(EmployeeInventoryAllocation allocation) {
    router.routeEmployeeInventoryAllocationsPageToRegisterCountingPage(
        InventoryCountingAllocation(beepInventory: _beepInventory, employeeInventoryAllocation: allocation));
  }
}
