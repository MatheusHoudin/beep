import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/employee_inventory_data.dart';
import 'package:beep/shared/repository/employeeinventoryallocations/fetch_employee_inventory_data_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchEmployeeInventoryDataUseCase
    extends AsyncBaseUseCase<EmployeeInventoryData, FetchEmployeeInventoryDataParams> {
  final FetchEmployeeInventoryDataRepository repository;

  FetchEmployeeInventoryDataUseCase({this.repository});

  @override
  Future<Either<Failure, EmployeeInventoryData>> call(
      FetchEmployeeInventoryDataParams params) async {
    return await repository.fetchEmployeeInventoryData(params.inventoryCode);
  }
}

class FetchEmployeeInventoryDataParams extends Equatable {
  final String inventoryCode;

  FetchEmployeeInventoryDataParams({this.inventoryCode});

  @override
  List<Object> get props => [inventoryCode];
}
