import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';

abstract class RegisterInventoryCountingSessionAllocationRemoteDataSource {
  Future registerInventoryCountingSessionAllocation(String companyCode, String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation);
}

class RegisterInventoryCountingSessionAllocationRemoteDataSourceImpl
    extends RegisterInventoryCountingSessionAllocationRemoteDataSource {
  final BeepInventoryRepository repository;

  RegisterInventoryCountingSessionAllocationRemoteDataSourceImpl({this.repository});

  @override
  Future registerInventoryCountingSessionAllocation(String companyCode, String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation) async {
    await repository.registerInventoryCountingSessionAllocation(
        companyCode, inventoryCode, countingSession, inventoryCountingSessionAllocation);
  }
}
