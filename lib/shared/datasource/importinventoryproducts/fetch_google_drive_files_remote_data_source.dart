import 'package:beep/core/network/google_http_client.dart';
import 'package:googleapis/drive/v3.dart' as ga;

abstract class FetchGoogleDriveFilesRemoteDataSource {
  Future<List<ga.File>> fetchGoogleDriveFilesRemoteDataSource(Map<String, String> authHeaders);
}

class FetchGoogleDriveFilesRemoteDataSourceImpl extends FetchGoogleDriveFilesRemoteDataSource {
  @override
  Future<List<ga.File>> fetchGoogleDriveFilesRemoteDataSource(Map<String, String> authHeaders) async {

    var client = GoogleHttpClient(authHeaders);
    var drive = ga.DriveApi(client);
    final fileList = await drive.files.list(
      spaces: 'drive',
      pageSize: 20,
      q: "mimeType= 'application/vnd.google-apps.spreadsheet'"
    );

    return fileList.files;
  }
}


