import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/fetch_inventory_counting_sessions_options_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';
import 'package:dartz/dartz.dart';

abstract class FetchInventoryCountingSessionsOptionsRepository {
  Future<Either<Failure, BeepInventoryCountingSessionsOptions>> fetchInventoryCountingSessionsOptions(String inventoryCode);
}

class FetchInventoryCountingSessionsOptionsRepositoryImpl extends FetchInventoryCountingSessionsOptionsRepository {
  final FetchInventoryCountingSessionsOptionsRemoteDataSource fetchInventoryCountingSessionsRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  FetchInventoryCountingSessionsOptionsRepositoryImpl(
      {this.fetchInventoryCountingSessionsRemoteDataSource, this.userLocalDataSource, this.networkInfo});

  @override
  Future<Either<Failure, BeepInventoryCountingSessionsOptions>> fetchInventoryCountingSessionsOptions(
      String inventoryCode) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final beepUser = userLocalDataSource.getLoggedUser();

      final inventoryCountingSessions = await fetchInventoryCountingSessionsRemoteDataSource
          .fetchInventoryCountingSessionsOptions(beepUser.companyCode, inventoryCode);

      return Right(inventoryCountingSessions);
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
