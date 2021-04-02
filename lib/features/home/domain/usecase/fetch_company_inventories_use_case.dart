import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/repository/listinventory/fetch_company_inventories_repository.dart';
import 'package:dartz/dartz.dart';

class FetchCompanyInventoriesUseCase extends BaseUseCase<Future<Either<Failure, List<BeepInventory>>>, FetchCompanyInventoriesParams> {
  final FetchCompanyInventoriesRepository repository;

  FetchCompanyInventoriesUseCase({this.repository});

  @override
  Future<Either<Failure, List<BeepInventory>>> call(FetchCompanyInventoriesParams params) async {
    return await repository.fetchCompanyInventories(params.companyCode);
  }
}

class FetchCompanyInventoriesParams {
  final String companyCode;

  FetchCompanyInventoriesParams({this.companyCode});
}
