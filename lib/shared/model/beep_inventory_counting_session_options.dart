import 'package:beep/shared/model/inventory_employee.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:equatable/equatable.dart';

class BeepInventoryCountingSessionsOptions extends Equatable {
  final List<InventoryLocation> locations;
  final List<InventoryEmployee> employees;

  BeepInventoryCountingSessionsOptions({this.locations, this.employees});

  @override
  List<Object> get props => [this.locations, this.employees];
}
