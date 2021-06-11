import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/repository/employeeinventoryallocations/fetch_employee_inventory_allocations_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchEmployeeInventoryAllocationsUseCase
    extends AsyncBaseUseCase<List<EmployeeInventoryAllocation>, FetchEmployeeInventoryAllocationsParams> {
  final FetchEmployeeInventoryAllocationsRepository repository;

  FetchEmployeeInventoryAllocationsUseCase({this.repository});

  @override
  Future<Either<Failure, List<EmployeeInventoryAllocation>>> call(
      FetchEmployeeInventoryAllocationsParams params) async {
    return await repository.fetchEmployeeInventoryAllocations(params.inventoryCode);
  }
}

class FetchEmployeeInventoryAllocationsParams extends Equatable {
  final String inventoryCode;

  FetchEmployeeInventoryAllocationsParams({this.inventoryCode});

  @override
  List<Object> get props => [inventoryCode];
}
