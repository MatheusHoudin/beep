import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';

abstract class ChangeAllocationStatusRemoteDataSource {
  Future changeInventoryAllocationStatus(
      String companyCode, String inventoryCode, EmployeeInventoryAllocation inventoryAllocation);
}

class ChangeAllocationStatusRemoteDataSourceImpl extends ChangeAllocationStatusRemoteDataSource {
  final BeepInventoryRepository repository;

  ChangeAllocationStatusRemoteDataSourceImpl({this.repository});

  @override
  Future changeInventoryAllocationStatus(
      String companyCode, String inventoryCode, EmployeeInventoryAllocation inventoryAllocation) async {
    try {
      return await repository.changeInventoryAllocationStatus(companyCode, inventoryCode, inventoryAllocation);
    } catch (e) {
      throw e;
    }
  }
}
