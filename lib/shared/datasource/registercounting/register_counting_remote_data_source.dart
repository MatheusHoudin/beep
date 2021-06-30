import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';

abstract class RegisterCountingRemoteDataSource {
  Future registerInventoryProductCounting(String companyCode, String inventoryCode,
      EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct);
}

class RegisterCountingRemoteDataSourceImpl extends RegisterCountingRemoteDataSource {
  final BeepInventoryRepository repository;

  RegisterCountingRemoteDataSourceImpl({this.repository});

  @override
  Future registerInventoryProductCounting(String companyCode, String inventoryCode,
      EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct) async {
    return await repository.registerInventoryProductCounting(
        companyCode, inventoryCode, inventoryAllocation, inventoryProduct);
  }
}
