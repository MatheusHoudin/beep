import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/login/login_remote_data_source.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:dartz/dartz.dart';
import 'package:beep/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> login(String email, String password);
}

class LoginRepositoryImpl extends LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;
  final SharedPreferences preferences;

  LoginRepositoryImpl({this.networkInfo, this.remoteDataSource, this.preferences});

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      return await _handleLogin(email, password);
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  Future<Either<Failure, void>> _handleLogin(String email, String password) async {
    try {
      BeepUser beepUser = await remoteDataSource.login(email, password);

      preferences.setString(userIdKey, beepUser.uid);
      preferences.setString(userEmailKey, beepUser.email);
      preferences.setString(userNameKey, beepUser.name);
      preferences.setString(userTypeKey, beepUser.type);
      preferences.setString(companyCodeKey, beepUser.companyCode);

    } on UserNotFoundException {
      return Left(UserNotFoundFailure(
        title: genericErrorMessageTitle,
        message: userNotFound
      ));
    } on WrongPasswordException {
      return Left(WrongPasswordFailure(
        title: genericErrorMessageTitle,
        message: wrongPassword
      ));
    } on InvalidEmailException {
      return Left(InvalidEmailFailure(
        title: genericErrorMessageTitle,
        message: invalidEmail
      ));
    } on GenericException {
      return Left(GenericFailure(
        title: genericErrorMessageTitle,
        message: genericErrorMessage
      ));
    }
  }
}
