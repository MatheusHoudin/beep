import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/importinventoryproducts/fetch_google_drive_files_remote_data_source.dart';
import 'package:beep/shared/datasource/importinventoryproducts/login_to_google_account_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:beep/core/error/failure.dart';

abstract class GetAvailableGoogleDriveFilesRepository {
  Future<Either<Failure, List<ga.File>>> getAvailableGoogleDriveFiles();
}

class GetAvailableGoogleDriveFilesRepositoryImpl extends GetAvailableGoogleDriveFilesRepository {
  final NetworkInfo networkInfo;
  final FetchGoogleDriveFilesRemoteDataSource fetchGoogleDriveFilesRemoteDataSource;
  final LoginToGoogleAccountRemoteDataSource loginToGoogleAccountRemoteDataSource;

  GetAvailableGoogleDriveFilesRepositoryImpl({
    this.networkInfo,
    this.fetchGoogleDriveFilesRemoteDataSource,
    this.loginToGoogleAccountRemoteDataSource
  });

  @override
  Future<Either<Failure, List<ga.File>>> getAvailableGoogleDriveFiles() async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      Map<String, String> authHeaders = await loginToGoogleAccountRemoteDataSource.loginToGoogleAccount();
      List<ga.File> fileList = await fetchGoogleDriveFilesRemoteDataSource.fetchGoogleDriveFilesRemoteDataSource(authHeaders);

      return Right(fileList);
    } on GenericException {
      return Left(GenericFailure());
    }
  }
}
