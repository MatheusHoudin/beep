import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/createinventory/create_inventory_remote_data_source.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:dartz/dartz.dart';

abstract class CreateInventoryRepository {
  Future<Either<Failure, void>> registerInventory(BeepInventory inventory);
}

class CreateInventoryRepositoryImpl extends CreateInventoryRepository {
  final AppPreferencesRepository preferences;
  final CreateInventoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CreateInventoryRepositoryImpl({
    this.preferences,
    this.remoteDataSource,
    this.networkInfo
  });

  @override
  Future<Either<Failure, void>> registerInventory(BeepInventory inventory) async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NoInternetConnectionFailure());
      }
      final companyCode = preferences.getString(companyCodeKey);

      await remoteDataSource.createInventory(inventory, companyCode);
    } on GenericException {
      return Left(GenericFailure(
        title: genericErrorMessageTitle,
        message: genericErrorMessage
      ));
    }
  }
}
