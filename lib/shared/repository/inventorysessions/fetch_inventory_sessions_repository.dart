import 'package:beep/core/error/failure.dart';
import 'package:beep/shared/datasource/inventorysessions/fetch_inventory_sessions_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:dartz/dartz.dart';

abstract class FetchInventorySessionsRepository {
  Future<Either<Failure, List<InventoryCountingSession>>> fetchInventorySessions(String inventoryCode);
}

class FetchInventorySessionsRepositoryImpl extends FetchInventorySessionsRepository {
  final FetchInventorySessionsRemoteDataSource fetchInventorySessionsRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  FetchInventorySessionsRepositoryImpl({this.fetchInventorySessionsRemoteDataSource, this.userLocalDataSource});

  @override
  Future<Either<Failure, List<InventoryCountingSession>>> fetchInventorySessions(String inventoryCode) async {
    try {
      final beepUser = userLocalDataSource.getLoggedUser();

      final inventorySessions = await fetchInventorySessionsRemoteDataSource.fetchInventoryCountingSessions(
          beepUser.companyCode, inventoryCode);

      return Right(inventorySessions);
    } catch (_) {
      return Left(GenericFailure());
    }
  }
}
