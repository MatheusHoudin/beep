import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';

abstract class FetchInventoryCountingSessionsOptionsRemoteDataSource {
  Future<BeepInventoryCountingSessionsOptions> fetchInventoryCountingSessionsOptions(String companyCode, String inventoryCode);
}

class FetchInventoryCountingSessionsOptionsRemoteDataSourceImpl extends FetchInventoryCountingSessionsOptionsRemoteDataSource {
  final BeepInventoryRepository beepInventoryRepository;

  FetchInventoryCountingSessionsOptionsRemoteDataSourceImpl({this.beepInventoryRepository});

  @override
  Future<BeepInventoryCountingSessionsOptions> fetchInventoryCountingSessionsOptions(
      String companyCode, String inventoryCode) async {
    return await beepInventoryRepository.fetchInventoryCountingSessionsOptions(companyCode, inventoryCode);
  }
}
