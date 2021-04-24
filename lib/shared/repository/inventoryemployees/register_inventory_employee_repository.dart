import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventoryemployees/register_inventory_employee_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:beep/core/error/failure.dart';

abstract class RegisterInventoryEmployeeRepository {
  Future<Either<Failure, void>> registerInventoryEmployee(String inventoryId, String userEmail);
}

class RegisterInventoryEmployeeRepositoryImpl extends RegisterInventoryEmployeeRepository {
  final UserLocalDataSource userLocalDataSource;
  final RegisterInventoryEmployeeRemoteDataSource registerInventoryEmployeeRemoteDataSource;
  final NetworkInfo networkInfo;

  RegisterInventoryEmployeeRepositoryImpl({
    this.userLocalDataSource,
    this.registerInventoryEmployeeRemoteDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, void>> registerInventoryEmployee(String inventoryId, String userEmail) async {
    if (!await networkInfo.isConnected)
      return Left(NoInternetConnectionFailure());
    try {
      final loggedInUser = userLocalDataSource.getLoggedUser();
      await registerInventoryEmployeeRemoteDataSource.registerInventoryEmployee(
          loggedInUser.companyCode,
          inventoryId,
          userEmail
      );
      return Right(null);
    } on InventoryUserNotFoundException {
      return Left(GenericFailure(
          message: registerInventoryEmployeeUserNotFound
      ));
    } on InventoryUserIsAlreadyRegisteredOnInventoryException {
      return Left(GenericFailure(
        message: registerInventoryEmployeeUserAlreadyRegistered
      ));
    } on Exception {
      return Left(GenericFailure());
    }
  }
}
