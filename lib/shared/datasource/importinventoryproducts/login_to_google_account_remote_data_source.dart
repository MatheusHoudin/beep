import 'package:beep/core/error/exception.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;

abstract class LoginToGoogleAccountRemoteDataSource {
  Future<Map<String, String>> loginToGoogleAccount();
}

class LoginToGoogleAccountRemoteDataSourceImpl extends LoginToGoogleAccountRemoteDataSource {
  @override
  Future<Map<String, String>> loginToGoogleAccount() async {
    try {
      final googleSignIn = signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveReadonlyScope]);
      final signIn.GoogleSignInAccount account = await googleSignIn.signIn();

      return await account.authHeaders;
    } on Exception {
      throw GenericException();
    }
  }
}
