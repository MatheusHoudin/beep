import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_inventory_counting_session_options.dart';
import 'package:beep/shared/repository/inventorycountingsessions/fetch_inventory_counting_sessions_options_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventoryCountingSessionsOptionsUseCase
    extends AsyncBaseUseCase<BeepInventoryCountingSessionsOptions, FetchInventoryCountingSessionsOptionsParams> {
  final FetchInventoryCountingSessionsOptionsRepository repository;

  FetchInventoryCountingSessionsOptionsUseCase({this.repository});

  @override
  Future<Either<Failure, BeepInventoryCountingSessionsOptions>> call(
      FetchInventoryCountingSessionsOptionsParams params) async {
    return await repository.fetchInventoryCountingSessionsOptions(params.inventoryCode);
  }
}

class FetchInventoryCountingSessionsOptionsParams extends Equatable {
  final String inventoryCode;

  FetchInventoryCountingSessionsOptionsParams({this.inventoryCode});

  @override
  List<Object> get props => [this.inventoryCode];
}
