import 'package:beep/shared/model/inventory_employee.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:equatable/equatable.dart';

class InventoryCountingSessionAllocation extends Equatable {
  final InventoryLocation location;
  final InventoryEmployee employee;

  InventoryCountingSessionAllocation({this.employee, this.location});

  factory InventoryCountingSessionAllocation.fromJson(Map<String, dynamic> json) {
    return InventoryCountingSessionAllocation(
      employee: InventoryEmployee.fromJson(json['employee']),
      location: InventoryLocation.fromJson(json['location'])
    );
  }

  Map<String, dynamic> toJson() {
    return {'employee': employee.toJson(), 'location': location.toJson()};
  }

  @override
  List<Object> get props => [this.employee, this.location];
}
