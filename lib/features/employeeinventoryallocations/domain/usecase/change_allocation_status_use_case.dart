import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/repository/changeallocationstatus/change_allocation_status_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangeAllocationStatusUseCase extends AsyncBaseUseCase<void, ChangeAllocationStatusParams> {
  final ChangeAllocationStatusRepository repository;

  ChangeAllocationStatusUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(ChangeAllocationStatusParams params) async {
    return await repository.changeAllocationStatus(params.inventoryCode, params.inventoryAllocation);
  }
}

class ChangeAllocationStatusParams extends Equatable {
  final String inventoryCode;
  final EmployeeInventoryAllocation inventoryAllocation;

  ChangeAllocationStatusParams({this.inventoryAllocation, this.inventoryCode});

  @override
  List<Object> get props => [inventoryAllocation, inventoryCode];
}
