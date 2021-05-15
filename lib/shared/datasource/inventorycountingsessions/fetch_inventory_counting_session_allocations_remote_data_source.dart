import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';

abstract class FetchInventoryCountingSessionAllocationsRemoteDataSource {
  Future<List<InventoryCountingSessionAllocation>> fetchInventoryCountingSessionAllocations(
      String companyCode, String inventoryCode, String countingSession);
}

class FetchInventoryCountingSessionAllocationsRemoteDataSourceImpl
    extends FetchInventoryCountingSessionAllocationsRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchInventoryCountingSessionAllocationsRemoteDataSourceImpl({this.repository});

  @override
  Future<List<InventoryCountingSessionAllocation>> fetchInventoryCountingSessionAllocations(
      String companyCode, String inventoryCode, String countingSession) async {
    return await repository.fetchInventoryCountingSessionAllocations(companyCode, inventoryCode, countingSession);
  }
}
