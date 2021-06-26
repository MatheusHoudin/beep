import 'package:beep/shared/model/employee_allocation.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:equatable/equatable.dart';

class EmployeeInventoryAllocation extends Equatable {
  final EmployeeAllocation employeeAllocation;
  final InventoryLocation inventoryLocation;
  final String session, status;

  EmployeeInventoryAllocation({this.employeeAllocation, this.inventoryLocation, this.session, this.status});

  factory EmployeeInventoryAllocation.fromJson(Map<String, dynamic> json) {
    return EmployeeInventoryAllocation(
        employeeAllocation: EmployeeAllocation.fromJson(json['employee']),
        inventoryLocation: InventoryLocation.fromJson(json['location']),
        session: json['session'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'employee': employeeAllocation.toJson(),
      'location': inventoryLocation.toJson(),
      'session': session,
      'status': status
    };
  }

  @override
  List<Object> get props => [employeeAllocation, inventoryLocation, session, status];
}
