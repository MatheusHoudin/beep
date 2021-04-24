import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/core/validator/validator.dart';
import 'package:beep/shared/repository/inventoryemployees/register_inventory_employee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterInventoryEmployeeUseCase extends AsyncBaseUseCase<void, RegisterInventoryEmployeeParams> {
  final RegisterInventoryEmployeeRepository repository;

  RegisterInventoryEmployeeUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterInventoryEmployeeParams params) async {
    if (!Validator.isEmailValid(params.userEmail))
      return Future.value(Left(InvalidEmailFailure(
          title: genericErrorMessageTitle,
          message: invalidEmail
      )));

    return await repository.registerInventoryEmployee(params.inventoryId, params.userEmail);
  }
}

class RegisterInventoryEmployeeParams extends Equatable {
  final String userEmail, inventoryId;

  RegisterInventoryEmployeeParams({this.userEmail, this.inventoryId});

  @override
  List<Object> get props => [userEmail, inventoryId];
}
