import 'package:beep/shared/datasource/inventorylocations/register_inventory_location_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/exception.dart';
import '../../../core/network/network_info.dart';

abstract class RegisterInventoryLocationRepository {
  Future<Either<Failure, void>> registerInventoryLocation(String inventoryCode, InventoryLocation inventoryLocation);
}

class RegisterInventoryLocationRepositoryImpl extends RegisterInventoryLocationRepository {
  final RegisterInventoryLocationRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  RegisterInventoryLocationRepositoryImpl({this.remoteDataSource, this.userLocalDataSource, this.networkInfo});

  @override
  Future<Either<Failure, void>> registerInventoryLocation(
      String inventoryCode, InventoryLocation inventoryLocation) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      BeepUser loggedUser = userLocalDataSource.getLoggedUser();

      await remoteDataSource.registerInventoryLocation(loggedUser.companyCode, inventoryCode, inventoryLocation);
    } on InventoryLocationAlreadyExistsException {
      return Left(NoInternetConnectionFailure());
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
