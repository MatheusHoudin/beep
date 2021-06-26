import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/employee_inventory_allocation.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/repository/registercounting/register_counting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterCountingUseCase extends AsyncBaseUseCase<void, RegisterCountingParams> {
  final RegisterCountingRepository repository;

  RegisterCountingUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterCountingParams params) async {
    return await repository.registerInventoryProductCounting(
        params.inventoryCode, params.inventoryAllocation, params.inventoryProduct);
  }
}

class RegisterCountingParams extends Equatable {
  final String inventoryCode;
  final EmployeeInventoryAllocation inventoryAllocation;
  final InventoryProduct inventoryProduct;

  RegisterCountingParams({this.inventoryAllocation, this.inventoryCode, this.inventoryProduct});

  @override
  List<Object> get props => [this.inventoryAllocation, this.inventoryCode, this.inventoryProduct];
}
