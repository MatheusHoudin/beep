import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_inventory.dart';

abstract class FetchEmployeeInventoriesRemoteDataSource {
  Future<List<BeepInventory>> fetchEmployeeStartedInventories(String companyCode);
}

class FetchEmployeeInventoriesRemoteDataSourceImpl extends FetchEmployeeInventoriesRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchEmployeeInventoriesRemoteDataSourceImpl({this.repository});

  @override
  Future<List<BeepInventory>> fetchEmployeeStartedInventories(String companyCode) async {
    try {
      return await repository.fetchCompanyStartedInventories(companyCode);
    } catch (e) {
      throw e;
    }
  }
}
