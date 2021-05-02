import 'package:beep/shared/model/inventory_location.dart';

import '../../../core/model_repository/beep_inventory_repository.dart';

abstract class RegisterInventoryLocationRemoteDataSource {
  Future registerInventoryLocation(String companyCode, String inventoryCode, InventoryLocation inventoryLocation);
}

class RegisterInventoryLocationRemoteDataSourceImpl extends RegisterInventoryLocationRemoteDataSource {
  final BeepInventoryRepository repository;

  RegisterInventoryLocationRemoteDataSourceImpl({this.repository});

  @override
  Future registerInventoryLocation(
      String companyCode, String inventoryCode, InventoryLocation inventoryLocation) async {
    return await repository.registerInventoryLocation(companyCode, inventoryCode, inventoryLocation);
  }
}
