import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';

abstract class RegisterInventorySessionRemoteDataSource {
  Future registerInventorySession(
      String companyCode, String inventoryCode, InventoryCountingSession inventoryCountingSession);
}

class RegisterInventorySessionRemoteDataSourceImpl extends RegisterInventorySessionRemoteDataSource {
  final BeepInventoryRepository repository;

  RegisterInventorySessionRemoteDataSourceImpl({this.repository});

  @override
  Future registerInventorySession(
      String companyCode, String inventoryCode, InventoryCountingSession inventoryCountingSession) async {
    try {
      return await repository.registerInventoryCountingSession(companyCode, inventoryCode, inventoryCountingSession);
    } catch (e) {
      throw e;
    }
  }
}
