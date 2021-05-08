import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:beep/shared/model/inventory_counting_session_type.dart';
import 'package:beep/shared/repository/inventorysessions/register_inventory_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterInventorySessionUseCase extends AsyncBaseUseCase<void, RegisterInventorySessionParams> {
  final RegisterInventorySessionRepository repository;

  RegisterInventorySessionUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterInventorySessionParams params) async {
    if (params.name.isEmpty) return Left(GenericFailure(
      title: registerInventorySessionErrorTitle,
      message: invalidInventorySessionName
    ));

    if (params.type == null) return Left(GenericFailure(
      title: registerInventorySessionErrorTitle,
      message: invalidInventorySessionType
    ));

    final inventorySessionType =
        params.type == 'Contagem' ? InventoryCountingSessionType.Counting : InventoryCountingSessionType.Checking;

    return await repository.registerInventorySession(
        params.inventoryCode, InventoryCountingSession(name: params.name, type: inventorySessionType));
  }
}

class RegisterInventorySessionParams extends Equatable {
  final String name, type, inventoryCode;

  RegisterInventorySessionParams({this.name, this.type, this.inventoryCode});

  @override
  List<Object> get props => [name, type, inventoryCode];
}
