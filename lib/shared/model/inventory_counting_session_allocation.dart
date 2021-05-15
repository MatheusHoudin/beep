import 'package:beep/shared/model/inventory_employee.dart';
import 'package:equatable/equatable.dart';

class InventoryCountingSessionAllocation extends Equatable {
  final String location;
  final InventoryEmployee employee;

  InventoryCountingSessionAllocation({this.employee, this.location});

  Map<String, dynamic> toJson() {
    return {'employee': employee.toJson(), 'location': location};
  }

  @override
  List<Object> get props => [this.employee, this.location];
}
