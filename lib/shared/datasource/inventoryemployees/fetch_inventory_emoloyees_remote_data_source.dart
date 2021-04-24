import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_employee.dart';

abstract class FetchInventoryEmployeesRemoteDataSource {
  Future<List<InventoryEmployee>> fetchInventoryEmployees(String companyCode, String inventoryId);
}

class FetchInventoryEmployeesRemoteDataSourceImpl extends FetchInventoryEmployeesRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchInventoryEmployeesRemoteDataSourceImpl({this.repository});

  @override
  Future<List<InventoryEmployee>> fetchInventoryEmployees(String companyCode, String inventoryId) async {
    try {
      return await repository.fetchInventoryEmployees(companyCode, inventoryId);
    } catch(e) {
      throw e;
    }
  }
}
