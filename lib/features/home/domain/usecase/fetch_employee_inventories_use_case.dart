import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/repository/employeeinventories/fetch_employee_inventories_repository.dart';
import 'package:dartz/dartz.dart';

class FetchEmployeeInventoriesUseCase extends BaseUseCase<Future<Either<Failure, List<BeepInventory>>>, FetchEmployeeInventoriesParams> {
  final FetchEmployeeInventoriesRepository repository;

  FetchEmployeeInventoriesUseCase({this.repository});

  @override
  Future<Either<Failure, List<BeepInventory>>> call(FetchEmployeeInventoriesParams params) async {
    return await repository.fetchEmployeeInventories();
  }
}

class FetchEmployeeInventoriesParams {}
