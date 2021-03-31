import 'dart:convert';
import 'dart:io';
import 'package:beep/core/extension/string_extensions.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/importinventoryproducts/google_drive_files_remote_data_source.dart';
import 'package:beep/shared/datasource/importinventoryproducts/login_to_google_account_remote_data_source.dart';
import 'package:beep/shared/model/imported_inventory_product.dart';
import 'package:dartz/dartz.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:beep/core/error/failure.dart';
import 'package:path_provider/path_provider.dart';

abstract class GetAvailableGoogleDriveFilesRepository {
  Future<Either<Failure, List<ga.File>>> getAvailableGoogleDriveFiles();
  Future<Either<Failure, List<ImportedInventoryProduct>>> importInventoryProducts(String fileId);
}

class GetAvailableGoogleDriveFilesRepositoryImpl extends GetAvailableGoogleDriveFilesRepository {
  final NetworkInfo networkInfo;
  final GoogleDriveFilesRemoteDataSource googleDriveFilesRemoteDataSource;
  final LoginToGoogleAccountRemoteDataSource loginToGoogleAccountRemoteDataSource;

  Map<String, String> authHeaders;

  GetAvailableGoogleDriveFilesRepositoryImpl({
    this.networkInfo,
    this.googleDriveFilesRemoteDataSource,
    this.loginToGoogleAccountRemoteDataSource
  });

  @override
  Future<Either<Failure, List<ga.File>>> getAvailableGoogleDriveFiles() async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      authHeaders = await loginToGoogleAccountRemoteDataSource.loginToGoogleAccount();
      List<ga.File> fileList = await googleDriveFilesRemoteDataSource.fetchGoogleDriveFilesRemoteDataSource(authHeaders);

      return Right(fileList);
    } on GenericException {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImportedInventoryProduct>>> importInventoryProducts(String fileId) async {
    if (!await networkInfo.isConnected) return Left(NoInternetConnectionFailure());

    try {
      await googleDriveFilesRemoteDataSource.downloadFile(fileId, authHeaders);

      final directory = await getExternalStorageDirectory();
      final downloadedFile = File('${directory.path}/$fileId');

      final fileContent = await downloadedFile.readAsString();

      return Right(convertStringFileToImportedInventoryProducts(fileContent));
    } on InvalidInventoryProductsFileException catch (e) {
      return Left(InvalidInventoryProductsFileFailure(
        title: "Ocorreu um erro na importação dos produtos",
        message: e.message
      ));
    } on GenericException {
      return Left(GenericFailure());
    }
  }

  List<ImportedInventoryProduct> convertStringFileToImportedInventoryProducts(String fileContent) {
    if (fileContent == null || fileContent.isEmpty)
      throw InvalidInventoryProductsFileException(
        message: "O conteúdo do arquivo está vazio"
      );

    List<String> lines = LineSplitter().convert(fileContent);

    return lines.map((line) {
      List<String> separatedLineFields = line.split(',');

      _validateLineHasThreeFields(separatedLineFields, line);
      _validateFieldsAreNotEmpty(separatedLineFields, line);
      _validateEanHasOnlyNumbers(separatedLineFields[1], line);
      _validatePackaging(separatedLineFields[2], line);

      return ImportedInventoryProduct(
        name: separatedLineFields[0],
        code: separatedLineFields[1],
        inventoryProductPackaging: separatedLineFields[2].convertStringToInventoryProductPackaging()
      );
    }).toList();
  }

  void _validateLineHasThreeFields(List<String> separatedLineFields, String line) {
    if (separatedLineFields.length != 3)
      throw InvalidInventoryProductsFileException(
          message: "A seguinte linha não contém os 3 campos requeridos: $line"
      );
  }

  void _validateFieldsAreNotEmpty(List<String> separatedLineFields, String line) {
    if (separatedLineFields[0].isEmpty || separatedLineFields[1].isEmpty || separatedLineFields[2].isEmpty)
      throw InvalidInventoryProductsFileException(
          message: "A seguinte linha contém campo vazio: $line"
      );
  }

  void _validateEanHasOnlyNumbers(String ean, String line) {
    if (double.tryParse(ean) == null)
      throw InvalidInventoryProductsFileException(
          message: "O EAN da seguinte linha contém caracteres inválidos, somente números são aceitos: $line"
      );
  }

  void _validatePackaging(String packaging, String line) {
    if (packaging != "UND" && packaging != "KG")
      throw InvalidInventoryProductsFileException(
          message: "O tipo da embalagem deve ser UND ou KG, o tipo provido na linha seguinte está desconforme: $line"
      );
  }
}
