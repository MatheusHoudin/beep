import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_location.dart';
import 'package:beep/shared/repository/inventorylocations/fetch_inventory_locations_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventoryLocationsUseCase extends AsyncBaseUseCase<List<InventoryLocation>, FetchInventoryParams> {
  final FetchInventoryLocationsRepository repository;

  FetchInventoryLocationsUseCase({this.repository});

  @override
  Future<Either<Failure, List<InventoryLocation>>> call(FetchInventoryParams params) async {
    return await repository.fetchInventoryLocations(params.inventoryCode);
  }
}

class FetchInventoryParams extends Equatable {
  final String inventoryCode;

  FetchInventoryParams({this.inventoryCode});

  @override
  List<Object> get props => [this.inventoryCode];
}
