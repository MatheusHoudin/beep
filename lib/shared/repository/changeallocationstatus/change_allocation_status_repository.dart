import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/changeallocationstatus/change_allocation_status_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:dartz/dartz.dart';

abstract class ChangeAllocationStatusRepository {
  Future<Either<Failure, void>> changeAllocationStatus(
      String inventoryCode, EmployeeInventoryAllocation inventoryAllocation);
}

class ChangeAllocationStatusRepositoryImpl extends ChangeAllocationStatusRepository {
  final NetworkInfo networkInfo;
  final ChangeAllocationStatusRemoteDataSource changeAllocationStatusRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  ChangeAllocationStatusRepositoryImpl(
      {this.networkInfo, this.changeAllocationStatusRemoteDataSource, this.userLocalDataSource});

  @override
  Future<Either<Failure, void>> changeAllocationStatus(
      String inventoryCode, EmployeeInventoryAllocation inventoryAllocation) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final beepUser = userLocalDataSource.getLoggedUser();

      await changeAllocationStatusRemoteDataSource.changeInventoryAllocationStatus(
          beepUser.companyCode, inventoryCode, inventoryAllocation);
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
