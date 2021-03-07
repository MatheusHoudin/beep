import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/core/validator/validator.dart';
import 'package:beep/shared/repository/login/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends BaseUseCase<void, LoginParams> {
  LoginRepository loginRepository;

  LoginUseCase({this.loginRepository});

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {

    if (!Validator.isEmailValid(params.email))
      return Future.value(Left(InvalidEmailFailure(
          title: genericErrorMessageTitle,
          message: invalidEmail
      )));

    return await loginRepository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email, password;

  LoginParams({this.email, this.password});

  @override
  List<Object> get props => [];
}
