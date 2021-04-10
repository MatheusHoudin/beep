import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/beep_inventory.dart';

abstract class FetchInventoryDetailsRemoteDataSource {
  Future<BeepInventory> fetchInventoryDetails(String companyCode, String inventoryId);
}

class FetchInventoryDetailsRemoteDataSourceImpl extends FetchInventoryDetailsRemoteDataSource {
  final BeepInventoryRepository beepInventoryRepository;

  FetchInventoryDetailsRemoteDataSourceImpl({this.beepInventoryRepository});

  @override
  Future<BeepInventory> fetchInventoryDetails(String companyCode, String inventoryId) async {
    try {
      return await beepInventoryRepository.fetchInventoryData(companyCode, inventoryId);
    } on Exception {
      throw GenericException();
    }
  }
}
