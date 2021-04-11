import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/shared/model/inventory_product.dart';

abstract class InventoryProductsRemoteDataSource {
  Future importInventoryProductsToInventory(
    String companyCode,
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  );
}

class InventoryProductsRemoteDataSourceImpl extends InventoryProductsRemoteDataSource {
  final BeepInventoryRepository beepInventoryRepository;

  InventoryProductsRemoteDataSourceImpl({this.beepInventoryRepository});

  @override
  Future importInventoryProductsToInventory(
    String companyCode,
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  ) async {
    try {
      return await beepInventoryRepository.importInventoryProductsToInventory(
        companyCode,
        inventoryCode,
        inventoryProducts
      );
    } on Exception {
      throw GenericException();
    }
  }
}
