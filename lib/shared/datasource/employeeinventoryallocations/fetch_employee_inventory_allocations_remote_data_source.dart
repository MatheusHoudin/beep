import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';

abstract class FetchEmployeeInventoryAllocationsRemoteDataSource {
  Future<List<EmployeeInventoryAllocation>> fetchEmployeeInventoryAllocations(
      String inventoryCode, BeepUser loggedUser);
}

class FetchEmployeeInventoryAllocationsRemoteDataSourceImpl extends FetchEmployeeInventoryAllocationsRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchEmployeeInventoryAllocationsRemoteDataSourceImpl({this.repository});

  @override
  Future<List<EmployeeInventoryAllocation>> fetchEmployeeInventoryAllocations(
      String inventoryCode, BeepUser loggedUser) async {
    return await repository.fetchEmployeeInventoryAllocations(inventoryCode, loggedUser);
  }
}
