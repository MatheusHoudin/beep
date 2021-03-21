import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/listinventory/fetch_company_inventories_remote_data_source.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:dartz/dartz.dart';

abstract class FetchCompanyInventoriesRepository {
  Future<Either<Failure, List<BeepInventory>>> fetchCompanyInventories(String companyCode);
}

class FetchCompanyInventoriesRepositoryImpl extends FetchCompanyInventoriesRepository {
  final NetworkInfo networkInfo;
  final FetchCompanyInventoriesRemoteDataSource remoteDataSource;

  FetchCompanyInventoriesRepositoryImpl({
    this.remoteDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, List<BeepInventory>>> fetchCompanyInventories(String companyCode) async {
    if (await networkInfo.isConnected) {
      try {
        final companyInventories = await remoteDataSource.fetchCompanyInventories(companyCode);

        return Right(companyInventories);
      } on GenericException {
        return Left(GenericFailure());
      }
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
