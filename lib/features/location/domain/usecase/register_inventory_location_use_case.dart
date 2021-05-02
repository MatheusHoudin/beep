import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/repository/locations/register_inventory_location_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterInventoryLocationUseCase extends AsyncBaseUseCase<void, RegisterInventoryLocationParams> {
  final RegisterInventoryLocationRepository repository;

  RegisterInventoryLocationUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterInventoryLocationParams params) async {
    if (params.name.isEmpty)
      return Left(InvalidInventoryLocationNameFailure(
          title: genericErrorMessageTitle, message: addInventoryLocationInvalidNameError));

    return await repository.registerInventoryLocation(
      params.inventoryCode,
      InventoryLocation(name: params.name, description: params.description)
    );
  }
}

class RegisterInventoryLocationParams extends Equatable {
  final String name, description, inventoryCode;

  RegisterInventoryLocationParams({this.name, this.description, this.inventoryCode});

  @override
  List<Object> get props => [this.name, this.description, this.inventoryCode];
}
