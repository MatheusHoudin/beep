import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_counting_session.dart';
import 'package:beep/shared/repository/inventorysessions/fetch_inventory_sessions_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventorySessionsUseCase
    extends AsyncBaseUseCase<List<InventoryCountingSession>, FetchInventorySessionsParams> {
  final FetchInventorySessionsRepository repository;

  FetchInventorySessionsUseCase({this.repository});

  @override
  Future<Either<Failure, List<InventoryCountingSession>>> call(FetchInventorySessionsParams params) async {
    return await repository.fetchInventorySessions(params.inventoryCode);
  }
}

class FetchInventorySessionsParams extends Equatable {
  final String inventoryCode;

  FetchInventorySessionsParams({this.inventoryCode});

  @override
  List<Object> get props => [inventoryCode];
}
