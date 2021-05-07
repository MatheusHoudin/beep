import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_location.dart';

abstract class FetchInventoryLocationsRemoteDataSource {
  Future<List<InventoryLocation>> fetchInventoryLocations(String companyCode, String inventoryCode);
}

class FetchInventoryLocationsRemoteDataSourceImpl extends FetchInventoryLocationsRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchInventoryLocationsRemoteDataSourceImpl({this.repository});

  @override
  Future<List<InventoryLocation>> fetchInventoryLocations(String companyCode, String inventoryCode) async {
    return await repository.fetchInventoryLocations(companyCode, inventoryCode);
  }
}
