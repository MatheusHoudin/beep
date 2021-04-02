import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/importinventoryproducts/inventory_products_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:dartz/dartz.dart';

abstract class ImportCompanyInventoriesRepository {
  Future<Either<Failure, void>> importCompanyInventories(
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  );
}

class ImportCompanyInventoriesRepositoryImpl extends ImportCompanyInventoriesRepository {
  final UserLocalDataSource dataSource;
  final InventoryProductsRemoteDataSource inventoryProductsRemoteDataSource;
  final NetworkInfo networkInfo;

  ImportCompanyInventoriesRepositoryImpl({
    this.dataSource,
    this.inventoryProductsRemoteDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, void>> importCompanyInventories(
    String inventoryCode,
    List<InventoryProduct> inventoryProducts
  ) async {
    if (!await networkInfo.isConnected)
      return Left(NoInternetConnectionFailure());

    try {
      BeepUser loggedUser = dataSource.getLoggedUser();

      return await inventoryProductsRemoteDataSource.importInventoryProductsToInventory(
        loggedUser.companyCode,
        inventoryCode,
        inventoryProducts
      );
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
