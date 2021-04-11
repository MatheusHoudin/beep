import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/core/validator/validator.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:beep/shared/repository/register/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUseCase extends AsyncBaseUseCase<void, RegisterParams> {
  RegisterRepository repository;

  RegisterUseCase({this.repository});

  @override
  Future<Either<Failure, void>> call(RegisterParams params) async {
    if (!Validator.isNameValid(params.name))
      return Future.value(Left(InvalidNameFailure(
        title: genericErrorMessageTitle,
        message: invalidName
      )));

    if (!Validator.isEmailValid(params.email))
      return Future.value(Left(InvalidEmailFailure(
        title: genericErrorMessageTitle,
        message: invalidEmail
      )));

    if (!Validator.isPasswordValid(params.password))
      return Future.value(Left(WeakPasswordFailure(
        title: genericErrorMessageTitle,
        message: weakPassword
      )));

    return await repository.register(UserRegisterData(
      name: params.name,
      email: params.email,
      password: params.password
    ));
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String name;
  final String password;

  RegisterParams({this.email, this.name, this.password});

  @override
  List<Object> get props => [email, name, password];
}
