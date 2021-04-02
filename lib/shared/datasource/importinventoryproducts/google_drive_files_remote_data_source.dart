import 'dart:io';

import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/google_http_client.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:path_provider/path_provider.dart';

abstract class GoogleDriveFilesRemoteDataSource {
  Future<List<ga.File>> fetchGoogleDriveFilesRemoteDataSource(Map<String, String> authHeaders);
  Future downloadFile(String fileId, Map<String, String> authHeaders);
}

class GoogleDriveFilesRemoteDataSourceImpl extends GoogleDriveFilesRemoteDataSource {
  @override
  Future<List<ga.File>> fetchGoogleDriveFilesRemoteDataSource(Map<String, String> authHeaders) async {
    var client = GoogleHttpClient(authHeaders);
    var drive = ga.DriveApi(client);

    final fileList = await drive.files.list(
      spaces: 'drive',
      pageSize: 20,
      q: "mimeType= 'application/vnd.google-apps.spreadsheet'",
      $fields: 'files(id, name, createdTime)'
    );

    return fileList.files;
  }

  @override
  Future downloadFile(String fileId, Map<String, String> authHeaders) async {
    try {
      var client = GoogleHttpClient(authHeaders);
      var drive = ga.DriveApi(client);

      ga.Media downloadedFile = await drive.files.export(fileId, "text/csv", downloadOptions: ga.DownloadOptions.fullMedia);

      final directory = await getExternalStorageDirectory();
      print(directory.path);
      final saveFile = File('${directory.path}/$fileId');
      List<int> dataStore = [];

      return downloadedFile.stream.listen((data) {
        print("DataReceived: ${data.length}");
        dataStore.insertAll(dataStore.length, data);
      }, onDone: () {
        print("Task Done");
        saveFile.writeAsBytes(dataStore);
        print("File saved at ${saveFile.path}");
      }, onError: (error) {
        throw GenericException();
      }).asFuture().whenComplete(() {
        print("Task Done");
        saveFile.writeAsBytes(dataStore);
        print("File saved at ${saveFile.path}");
      });
    } on Exception {
      throw GenericException();
    }
  }
}


