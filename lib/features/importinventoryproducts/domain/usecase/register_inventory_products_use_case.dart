import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/repository/importinventoryproducts/import_company_inventories_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterInventoryProductsUseCase extends BaseUseCase<Future<Either<Failure, void>>, RegisterInventoryProductsParams> {
  final ImportCompanyInventoriesRepository repository;

  RegisterInventoryProductsUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterInventoryProductsParams params) async {
    return await repository.importCompanyInventories(params.inventoryCode,params.inventoryProducts);
  }
}

class RegisterInventoryProductsParams extends Equatable {
  final List<InventoryProduct> inventoryProducts;
  final String inventoryCode;

  RegisterInventoryProductsParams({this.inventoryProducts, this.inventoryCode});

  @override
  List<Object> get props => [this.inventoryProducts, this.inventoryCode];
}
