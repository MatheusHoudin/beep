import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_product.dart';

abstract class FetchInventoryProductsRemoteDataSource {
  Future<List<InventoryProduct>> fetchInventoryProducts(String companyCode, String inventoryCode);
}

class FetchInventoryProductsRemoteDataSourceImpl extends FetchInventoryProductsRemoteDataSource {
  final BeepInventoryRepository repository;

  FetchInventoryProductsRemoteDataSourceImpl({this.repository});

  @override
  Future<List<InventoryProduct>> fetchInventoryProducts(String companyCode, String inventoryCode) async {
    try {
      return await repository.fetchInventoryProducts(companyCode, inventoryCode);
    } catch (e) {
      throw e;
    }
  }
}
