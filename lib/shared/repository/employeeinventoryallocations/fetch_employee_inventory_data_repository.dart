import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/employeeinventoryallocations/fetch_employee_inventory_allocations_remote_data_source.dart';
import 'package:beep/shared/datasource/inventoryproducts/fetch_inventory_products_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/employee_inventory_data.dart';
import 'package:dartz/dartz.dart';

abstract class FetchEmployeeInventoryDataRepository {
  Future<Either<Failure, EmployeeInventoryData>> fetchEmployeeInventoryData(String inventoryCode);
}

class FetchEmployeeInventoryDataRepositoryImpl extends FetchEmployeeInventoryDataRepository {
  final UserLocalDataSource userLocalDataSource;
  final FetchEmployeeInventoryAllocationsRemoteDataSource fetchEmployeeInventoryAllocationsRemoteDataSource;
  final FetchInventoryProductsRemoteDataSource fetchInventoryProductsRemoteDataSource;
  final NetworkInfo networkInfo;

  FetchEmployeeInventoryDataRepositoryImpl(
      {this.userLocalDataSource,
      this.fetchEmployeeInventoryAllocationsRemoteDataSource,
      this.networkInfo,
      this.fetchInventoryProductsRemoteDataSource});

  @override
  Future<Either<Failure, EmployeeInventoryData>> fetchEmployeeInventoryData(String inventoryCode) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final loggedUser = userLocalDataSource.getLoggedUser();
      final employeeInventoryAllocations = await fetchEmployeeInventoryAllocationsRemoteDataSource
          .fetchEmployeeInventoryAllocations(inventoryCode, loggedUser);

      final inventoryProducts =
          await fetchInventoryProductsRemoteDataSource.fetchInventoryProducts(loggedUser.companyCode, inventoryCode);

      return Right(EmployeeInventoryData(allocations: employeeInventoryAllocations, products: inventoryProducts));
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
