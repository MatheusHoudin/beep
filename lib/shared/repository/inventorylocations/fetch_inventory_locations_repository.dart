import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventorylocations/fetch_inventory_locations_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:dartz/dartz.dart';

abstract class FetchInventoryLocationsRepository {
  Future<Either<Failure, List<InventoryLocation>>> fetchInventoryLocations(String inventoryCode);
}

class FetchInventoryLocationsRepositoryImpl extends FetchInventoryLocationsRepository {
  final FetchInventoryLocationsRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  FetchInventoryLocationsRepositoryImpl({this.userLocalDataSource, this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, List<InventoryLocation>>> fetchInventoryLocations(String inventoryCode) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final loggedUser = userLocalDataSource.getLoggedUser();

      final inventoryLocations = await remoteDataSource.fetchInventoryLocations(loggedUser.companyCode, inventoryCode);
      return Right(inventoryLocations);
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
