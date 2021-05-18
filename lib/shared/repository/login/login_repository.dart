import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/login/login_remote_data_source.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:beep/core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> login(String email, String password);
}

class LoginRepositoryImpl extends LoginRepository {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource remoteDataSource;
  final AppPreferencesRepository preferences;

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
      await Future.any<bool>([
        preferences.saveString(userIdKey, beepUser.uid),
        preferences.saveString(userEmailKey, beepUser.email),
        preferences.saveString(userNameKey, beepUser.name),
        preferences.saveString(userTypeKey, beepUser.type),
      ]);
      if (beepUser.companyCode != null)
        await preferences.saveString(companyCodeKey, beepUser.companyCode);

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
