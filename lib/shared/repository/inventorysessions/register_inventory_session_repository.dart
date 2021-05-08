import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventorysessions/register_inventory_session_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterInventorySessionRepository {
  Future<Either<Failure, void>> registerInventorySession(
      String inventoryCode, InventoryCountingSession inventoryCountingSession);
}

class RegisterInventorySessionRepositoryImpl extends RegisterInventorySessionRepository {
  final RegisterInventorySessionRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  RegisterInventorySessionRepositoryImpl({this.networkInfo, this.remoteDataSource, this.userLocalDataSource});

  @override
  Future<Either<Failure, void>> registerInventorySession(
      String inventoryCode, InventoryCountingSession inventoryCountingSession) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final beepUser = userLocalDataSource.getLoggedUser();

      await remoteDataSource.registerInventorySession(beepUser.companyCode, inventoryCode, inventoryCountingSession);
    } on InventoryCountingSessionAlreadyExistsException {
      return Left(InventoryCountingSessionAlreadyExistsFailure(
          title: registerInventorySessionErrorTitle, message: registerInventorySessionErrorMessage));
    } on Exception {
      return Left(GenericFailure());
    }
  }
}
