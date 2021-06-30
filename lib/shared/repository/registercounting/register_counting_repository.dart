import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/registercounting/register_counting_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterCountingRepository {
  Future<Either<Failure, void>> registerInventoryProductCounting(
      String inventoryCode, EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct);
}

class RegisterCountingRepositoryImpl extends RegisterCountingRepository {
  final RegisterCountingRemoteDataSource registerCountingRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  RegisterCountingRepositoryImpl({this.registerCountingRemoteDataSource, this.userLocalDataSource, this.networkInfo});

  @override
  Future<Either<Failure, void>> registerInventoryProductCounting(
      String inventoryCode, EmployeeInventoryAllocation inventoryAllocation, InventoryProduct inventoryProduct) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final loggedUser = userLocalDataSource.getLoggedUser();

      await registerCountingRemoteDataSource.registerInventoryProductCounting(
          loggedUser.companyCode, inventoryCode, inventoryAllocation, inventoryProduct);
    } on InventoryAllocationNotFoundException {
      return Left(
          AllocationNotFoundFailure(title: genericErrorMessageTitle, message: registerCountingPageAllocationNotFound));
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
