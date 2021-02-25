import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/register/register_remote_data_source.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:dartz/dartz.dart';
import 'package:beep/core/constants/texts.dart';

abstract class RegisterRepository {
  Future<Either<Failure, void>> register(UserRegisterData userRegisterData);
}

class RegisterRepositoryImpl extends RegisterRepository {
  final NetworkInfo networkInfo;
  final RegisterRemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({this.networkInfo, this.remoteDataSource});

  @override
  Future<Either<Failure, void>> register(UserRegisterData userRegisterData) async {
    if (await networkInfo.isConnected) {
      return await _handleRegister(userRegisterData);
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }

  Future<Either<Failure, void>> _handleRegister(UserRegisterData userRegisterData) async {
    try {
      await remoteDataSource.registerUser(userRegisterData);
    } on WeakPasswordException {
      return Left(WeakPasswordFailure(
        title: genericErrorMessageTitle,
        message: weakPassword
      ));
    } on EmailAlreadyInUseException {
      return Left(EmailAlreadyInUseFailure(
        title: genericErrorMessageTitle,
        message: emailAlreadyInUse
      ));
    } on GenericException {
      return Left(GenericFailure(
        title: genericErrorMessageTitle,
        message: genericErrorMessage
      ));
    }
  }
}
