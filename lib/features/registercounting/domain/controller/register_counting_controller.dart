import 'package:beep/shared/model/inventory_counting_allocation.dart';
import 'package:get/get.dart';

abstract class RegisterCountingController extends GetxController {
  void initialize(InventoryCountingAllocation inventoryCountingAllocation);
  String getInventoryName();
  String getLocationName();
}

class RegisterCountingControllerImpl extends RegisterCountingController {
  InventoryCountingAllocation _inventoryCountingAllocation;

  @override
  void initialize(InventoryCountingAllocation inventoryCountingAllocation) {
    _inventoryCountingAllocation = inventoryCountingAllocation;
  }

  @override
  String getInventoryName() {
    return _inventoryCountingAllocation.beepInventory.name;
  }

  @override
  String getLocationName() {
    return _inventoryCountingAllocation.employeeInventoryAllocation.inventoryLocation.name;
  }
}
