import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/employeeinventories/fetch_employee_inventories_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:dartz/dartz.dart';

abstract class FetchEmployeeInventoriesRepository {
  Future<Either<Failure, List<BeepInventory>>> fetchEmployeeInventories();
}

class FetchEmployeeInventoriesRepositoryImpl extends FetchEmployeeInventoriesRepository {
  final UserLocalDataSource userLocalDataSource;
  final FetchEmployeeInventoriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FetchEmployeeInventoriesRepositoryImpl({this.userLocalDataSource, this.remoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<BeepInventory>>> fetchEmployeeInventories() async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final loggedUser = userLocalDataSource.getLoggedUser();
      final inventories = await remoteDataSource.fetchEmployeeStartedInventories(loggedUser.companyCode);

      return Right(inventories);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
