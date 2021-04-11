import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/inventory_product.dart';
import 'package:beep/shared/repository/importinventoryproducts/get_available_google_drive_files_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ImportInventoryProductsUseCase extends BaseUseCase<Future<Either<Failure, List<InventoryProduct>>>, ImportInventoryProductsParams> {
  final GetAvailableGoogleDriveFilesRepository repository;

  ImportInventoryProductsUseCase({this.repository});

  @override
  Future<Either<Failure, List<InventoryProduct>>> call(ImportInventoryProductsParams params) async {
    return await repository.importInventoryProducts(params.fileId);
  }
}

class ImportInventoryProductsParams extends Equatable {
  final String fileId;

  ImportInventoryProductsParams({this.fileId});

  @override
  List<Object> get props => [fileId];
}
