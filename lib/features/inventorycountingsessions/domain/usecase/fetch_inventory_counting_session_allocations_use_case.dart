import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/repository/inventorycountingsessions/fetch_inventory_counting_session_allocations_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventoryCountingSessionAllocationsUseCase
    extends AsyncBaseUseCase<List<InventoryCountingSessionAllocation>, FetchInventoryCountingSessionAllocationsParams> {
  final FetchInventoryCountingSessionAllocationsRepository repository;

  FetchInventoryCountingSessionAllocationsUseCase({this.repository});

  @override
  Future<Either<Failure, List<InventoryCountingSessionAllocation>>> call(
      FetchInventoryCountingSessionAllocationsParams params) async {
    return await repository.fetchInventoryCountingSessionAllocations(params.inventoryCode, params.session);
  }
}

class FetchInventoryCountingSessionAllocationsParams extends Equatable {
  final String inventoryCode, session;

  FetchInventoryCountingSessionAllocationsParams({this.inventoryCode, this.session});

  @override
  List<Object> get props => [this.inventoryCode, this.session];
}
