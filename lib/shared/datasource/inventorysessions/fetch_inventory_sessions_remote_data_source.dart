import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';

abstract class FetchInventorySessionsRemoteDataSource {
  Future<List<InventoryCountingSession>> fetchInventoryCountingSessions(String companyCode, String inventoryCode);
}

class FetchInventorySessionsRemoteDataSourceImpl extends FetchInventorySessionsRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchInventorySessionsRemoteDataSourceImpl({this.repository});

  @override
  Future<List<InventoryCountingSession>> fetchInventoryCountingSessions(
      String companyCode, String inventoryCode) async {
    try {
      return repository.fetchInventoryCountingSessions(companyCode, inventoryCode);
    } catch (e) {
      throw e;
    }
  }
}
