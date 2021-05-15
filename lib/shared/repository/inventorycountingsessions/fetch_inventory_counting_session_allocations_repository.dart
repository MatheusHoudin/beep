import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/fetch_inventory_counting_session_allocations_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:dartz/dartz.dart';

abstract class FetchInventoryCountingSessionAllocationsRepository {
  Future<Either<Failure, List<InventoryCountingSessionAllocation>>> fetchInventoryCountingSessionAllocations(
      String inventoryCode, String countingSession);
}

class FetchInventoryCountingSessionAllocationsRepositoryImpl
    extends FetchInventoryCountingSessionAllocationsRepository {
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;
  final FetchInventoryCountingSessionAllocationsRemoteDataSource
      fetchInventoryCountingSessionAllocationsRemoteDataSource;

  FetchInventoryCountingSessionAllocationsRepositoryImpl(
      {this.networkInfo, this.userLocalDataSource, this.fetchInventoryCountingSessionAllocationsRemoteDataSource});

  @override
  Future<Either<Failure, List<InventoryCountingSessionAllocation>>> fetchInventoryCountingSessionAllocations(
      String inventoryCode, String countingSession) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final beepUser = userLocalDataSource.getLoggedUser();
      final allocations = await fetchInventoryCountingSessionAllocationsRemoteDataSource
          .fetchInventoryCountingSessionAllocations(beepUser.companyCode, inventoryCode, countingSession);
      return Right(allocations);
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
