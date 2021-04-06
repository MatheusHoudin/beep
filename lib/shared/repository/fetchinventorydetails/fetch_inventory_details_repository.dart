import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/fetchinventorydetails/fetch_inventory_details_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:dartz/dartz.dart';

abstract class FetchInventoryDetailsRepository {
  Future<Either<Failure, BeepInventory>> fetchInventoryDetails(String inventoryId);
}

class FetchInventoryDetailsRepositoryImpl extends FetchInventoryDetailsRepository {
  final NetworkInfo networkInfo;
  final FetchInventoryDetailsRemoteDataSource fetchInventoryDetailsRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  FetchInventoryDetailsRepositoryImpl({
    this.networkInfo,
    this.fetchInventoryDetailsRemoteDataSource,
    this.userLocalDataSource
  });

  @override
  Future<Either<Failure, BeepInventory>> fetchInventoryDetails(String inventoryId) async {
    if (!await networkInfo.isConnected)
      return Left(NoInternetConnectionFailure());

    try {
      BeepUser beepUser = userLocalDataSource.getLoggedUser();

      final beepInventory = await fetchInventoryDetailsRemoteDataSource.fetchInventoryDetails(beepUser.companyCode, inventoryId);
      return Right(beepInventory);
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
