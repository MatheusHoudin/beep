import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_inventory.dart';

abstract class CreateInventoryRemoteDataSource {
  Future createInventory(BeepInventory inventory, String companyCode);
}

class CreateInventoryRemoteDataSourceImpl extends CreateInventoryRemoteDataSource {
  final BeepInventoryRepository repository;

  CreateInventoryRemoteDataSourceImpl({this.repository});

  @override
  Future createInventory(BeepInventory inventory, String companyCode) async {
    try {
      await repository.registerInventory(inventory, companyCode);
    } on Exception catch (e) {
      print(e);
      throw GenericException();
    }
  }
}
