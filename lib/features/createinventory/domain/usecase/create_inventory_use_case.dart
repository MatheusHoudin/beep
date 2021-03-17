import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/core/validator/validator.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/repository/createinventory/create_inventory_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateInventoryUseCase extends BaseUseCase<Future<Either<Failure, void>>, CreateInventoryParams> {
  final CreateInventoryRepository repository;

  CreateInventoryUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(CreateInventoryParams params) async {
    if (!Validator.isNameValid(params.name)) {
      return Future.value(Left(InvalidNameFailure(
        title: genericErrorMessageTitle,
        message: createInventoryInvalidName
      )));
    }
    if (!Validator.isNameValid(params.description)) {
      return Future.value(Left(InvalidNameFailure(
        title: genericErrorMessageTitle,
        message: createInventoryInvalidDescription
      )));
    }
    await repository.registerInventory(BeepInventory(
      name: params.name,
      description: params.description,
      time: params.time,
      date: params.date
    ));
  }

}

class CreateInventoryParams extends Equatable {
  final String name, date, time, description;

  CreateInventoryParams({
    this.name,
    this.description,
    this.time,
    this.date
  });

  @override
  List<Object> get props => [];
}
