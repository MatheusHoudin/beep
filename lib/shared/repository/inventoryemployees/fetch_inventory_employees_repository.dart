import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventoryemployees/fetch_inventory_emoloyees_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:dartz/dartz.dart';
import 'package:beep/core/error/failure.dart';

abstract class FetchInventoryEmployeesRepository {
  Future<Either<Failure, List<InventoryEmployee>>> fetchInventoryEmployees(
      String inventoryId);
}

class FetchInventoryEmployeesRepositoryImpl
    extends FetchInventoryEmployeesRepository {
  final NetworkInfo networkInfo;
  final FetchInventoryEmployeesRemoteDataSource
      fetchInventoryEmployeesRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  FetchInventoryEmployeesRepositoryImpl(
      {this.networkInfo,
      this.fetchInventoryEmployeesRemoteDataSource,
      this.userLocalDataSource});

  @override
  Future<Either<Failure, List<InventoryEmployee>>> fetchInventoryEmployees(
      String inventoryId) async {
    if (!await networkInfo.isConnected)
      return Left(NoInternetConnectionFailure());

    try {
      final loggedInUser = userLocalDataSource.getLoggedUser();
      final inventoryEmployees = await fetchInventoryEmployeesRemoteDataSource
          .fetchInventoryEmployees(loggedInUser.companyCode, inventoryId);

      return Right(inventoryEmployees);
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
