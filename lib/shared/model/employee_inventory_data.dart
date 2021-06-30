import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:equatable/equatable.dart';

class EmployeeInventoryData extends Equatable {
  final List<EmployeeInventoryAllocation> allocations;
  final List<InventoryProduct> products;

  EmployeeInventoryData({this.allocations, this.products});

  @override
  List<Object> get props => [allocations, products];
}
