import 'package:beep/core/model_repository/beep_inventory_repository.dart';

abstract class RegisterInventoryEmployeeRemoteDataSource {
  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail);
}

class RegisterInventoryEmployeeRemoteDataSourceImpl extends RegisterInventoryEmployeeRemoteDataSource {
  final BeepInventoryRepository beepInventoryRepository;

  RegisterInventoryEmployeeRemoteDataSourceImpl({this.beepInventoryRepository});

  @override
  Future registerInventoryEmployee(String companyCode, String inventoryId, String userEmail) async {
    try {
      await beepInventoryRepository.registerInventoryEmployee(companyCode, inventoryId, userEmail);
    } catch (e) {
      throw e;
    }
  }
}
