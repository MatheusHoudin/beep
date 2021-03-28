import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/repository/importinventoryproducts/get_available_google_drive_files_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:googleapis/drive/v3.dart' as ga;

class GetAvailableGoogleDriveFilesUseCase extends BaseUseCase<Future<Either<Failure, List<ga.File>>>, GetAvailableGoogleDriveFilesParams> {
  final GetAvailableGoogleDriveFilesRepository repository;

  GetAvailableGoogleDriveFilesUseCase({this.repository});

  @override
  Future<Either<Failure, List<ga.File>>> call(GetAvailableGoogleDriveFilesParams params) async {
    return await repository.getAvailableGoogleDriveFiles();
  }
}

class GetAvailableGoogleDriveFilesParams {}
