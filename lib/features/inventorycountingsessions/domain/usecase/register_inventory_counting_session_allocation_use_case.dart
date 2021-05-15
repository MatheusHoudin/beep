import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_counting_session_allocation.dart';
import 'package:beep/shared/repository/inventorycountingsessions/register_inventory_counting_session_allocation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterInventoryCountingSessionAllocationUseCase
    extends AsyncBaseUseCase<void, RegisterInventoryCountingSessionAllocationParams> {
  final RegisterInventoryCountingSessionAllocationRepository repository;

  RegisterInventoryCountingSessionAllocationUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterInventoryCountingSessionAllocationParams params) async {
    return await repository.registerInventoryCountingSessionAllocation(
        params.inventoryCode, params.session, params.inventoryCountingSessionAllocation);
  }
}

class RegisterInventoryCountingSessionAllocationParams extends Equatable {
  final String inventoryCode, session;
  final InventoryCountingSessionAllocation inventoryCountingSessionAllocation;

  RegisterInventoryCountingSessionAllocationParams(
      {this.inventoryCode, this.session, this.inventoryCountingSessionAllocation});

  @override
  List<Object> get props => [this.inventoryCode, this.session, this.inventoryCountingSessionAllocation];
}
