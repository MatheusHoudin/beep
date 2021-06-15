import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:equatable/equatable.dart';

class InventoryCountingAllocation extends Equatable {
  final BeepInventory beepInventory;
  final EmployeeInventoryAllocation employeeInventoryAllocation;

  InventoryCountingAllocation({this.beepInventory, this.employeeInventoryAllocation});

  @override
  List<Object> get props => [beepInventory, employeeInventoryAllocation];
}
