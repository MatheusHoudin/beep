import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_employee.dart';
import 'package:beep/shared/repository/inventoryemployees/fetch_inventory_employees_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventoryEmployeesUseCase extends AsyncBaseUseCase<List<InventoryEmployee>, FetchInventoryEmployeesParams> {
  final FetchInventoryEmployeesRepository repository;

  FetchInventoryEmployeesUseCase({this.repository});

  @override
  Future<Either<Failure, List<InventoryEmployee>>> call(FetchInventoryEmployeesParams params) async {
    return await repository.fetchInventoryEmployees(params.inventoryId);
  }
}

class FetchInventoryEmployeesParams extends Equatable {
  final String inventoryId;

  FetchInventoryEmployeesParams({this.inventoryId});

  @override
  List<Object> get props => [inventoryId];
}
