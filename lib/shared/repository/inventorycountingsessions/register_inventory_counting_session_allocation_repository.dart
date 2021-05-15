import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/inventorycountingsessions/register_inventory_counting_session_allocation_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterInventoryCountingSessionAllocationRepository {
  Future<Either<Failure, void>> registerInventoryCountingSessionAllocation(String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation);
}

class RegisterInventoryCountingSessionAllocationRepositoryImpl
    extends RegisterInventoryCountingSessionAllocationRepository {
  final NetworkInfo networkInfo;
  final UserLocalDataSource userLocalDataSource;
  final RegisterInventoryCountingSessionAllocationRemoteDataSource allocationRemoteDataSource;

  RegisterInventoryCountingSessionAllocationRepositoryImpl(
      {this.networkInfo, this.userLocalDataSource, this.allocationRemoteDataSource});

  @override
  Future<Either<Failure, void>> registerInventoryCountingSessionAllocation(String inventoryCode, String countingSession,
      InventoryCountingSessionAllocation inventoryCountingSessionAllocation) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      final beepUser = userLocalDataSource.getLoggedUser();
      await allocationRemoteDataSource.registerInventoryCountingSessionAllocation(
          beepUser.companyCode, inventoryCode, countingSession, inventoryCountingSessionAllocation);
    } on AllocationAlreadyExistsException {
      return Left(AllocationAlreadyExistsFailure(
          title: allocationAlreadyExistsFailureTitle, message: allocationAlreadyExistsFailureMessage));
    } on Exception {
      return Left(GenericFailure());
    }
  }
}
