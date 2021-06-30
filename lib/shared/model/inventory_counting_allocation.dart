import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:equatable/equatable.dart';

class InventoryCountingAllocation extends Equatable {
  final BeepInventory beepInventory;
  final EmployeeInventoryAllocation employeeInventoryAllocation;
  final List<InventoryProduct> products;

  InventoryCountingAllocation({this.beepInventory, this.employeeInventoryAllocation, this.products});

  @override
  List<Object> get props => [beepInventory, employeeInventoryAllocation, products];
}
