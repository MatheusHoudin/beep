import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/repository/fetchinventorydetails/fetch_inventory_details_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchInventoryDetailsUseCase extends BaseUseCase<Future<Either<Failure, BeepInventory>>, FetchInventoryDetailsParams> {
  final FetchInventoryDetailsRepository repository;

  FetchInventoryDetailsUseCase({this.repository});

  @override
  Future<Either<Failure, BeepInventory>> call(FetchInventoryDetailsParams params) async {
    return await repository.fetchInventoryDetails(params.inventoryId);
  }
}

class FetchInventoryDetailsParams extends Equatable {
  final String inventoryId;

  FetchInventoryDetailsParams({this.inventoryId});

  @override
  List<Object> get props => [this.inventoryId];
}
