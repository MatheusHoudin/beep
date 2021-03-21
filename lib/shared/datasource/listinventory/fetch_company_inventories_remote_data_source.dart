import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_inventory.dart';

abstract class FetchCompanyInventoriesRemoteDataSource {
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode);
}

class FetchCompanyInventoriesRemoteDataSourceImpl extends FetchCompanyInventoriesRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchCompanyInventoriesRemoteDataSourceImpl({this.repository});

  @override
  Future<List<BeepInventory>> fetchCompanyInventories(String companyCode) {
    try {
      return repository.fetchCompanyInventories(companyCode);
    } on Exception {
      throw GenericException();
    }
  }
}
