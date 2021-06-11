import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/datasource/employeeinventoryallocations/fetch_employee_inventory_allocations_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:dartz/dartz.dart';

abstract class FetchEmployeeInventoryAllocationsRepository {
  Future<Either<Failure, List<EmployeeInventoryAllocation>>> fetchEmployeeInventoryAllocations(String inventoryCode);
}

class FetchEmployeeInventoryAllocationsRepositoryImpl extends FetchEmployeeInventoryAllocationsRepository {
  final UserLocalDataSource userLocalDataSource;
  final FetchEmployeeInventoryAllocationsRemoteDataSource fetchEmployeeInventoryAllocationsRemoteDataSource;
  final NetworkInfo networkInfo;

  FetchEmployeeInventoryAllocationsRepositoryImpl(
      {this.userLocalDataSource, this.fetchEmployeeInventoryAllocationsRemoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<EmployeeInventoryAllocation>>> fetchEmployeeInventoryAllocations(
      String inventoryCode) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final loggedUser = userLocalDataSource.getLoggedUser();
      final employeeInventoryAllocations = await fetchEmployeeInventoryAllocationsRemoteDataSource
          .fetchEmployeeInventoryAllocations(inventoryCode, loggedUser);

      return Right(employeeInventoryAllocations);
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
