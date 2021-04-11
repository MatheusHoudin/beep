import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/features/register/domain/usecase/register_use_case.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:beep/shared/repository/register/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RegisterRepositoryMock extends Mock implements RegisterRepository {}

void main() {
  RegisterRepositoryMock repository;
  RegisterUseCase useCase;

  setUp(() {
    repository = RegisterRepositoryMock();
    useCase = RegisterUseCase(repository: repository);
  });

  test('Should return left with invalid name failure when name is null', () async {
    final result = await useCase.call(RegisterParams(
      email: "email@com.br",
      password: "password",
      name: null
    ));

    expect(result, Left(InvalidNameFailure(
        title: genericErrorMessageTitle,
        message: invalidName
    )));
  });

  test('Should return left with invalid name failure when name is empty', () async {
    final result = await useCase.call(RegisterParams(
        email: "email@com.br",
        password: "password",
        name: ""
    ));

    expect(result, Left(InvalidNameFailure(
        title: genericErrorMessageTitle,
        message: invalidName
    )));
  });

  test('Should return left with invalid email failure when email is null', () async {
    final result = await useCase.call(RegisterParams(
        email: null,
        password: "password",
        name: "name"
    ));

    expect(result, Left(InvalidEmailFailure(
        title: genericErrorMessageTitle,
        message: invalidEmail
    )));
  });

  test('Should return left with invalid email failure when email is invalid', () async {
    final result = await useCase.call(RegisterParams(
        email: "",
        password: "password",
        name: "name"
    ));

    expect(result, Left(InvalidEmailFailure(
        title: genericErrorMessageTitle,
        message: invalidEmail
    )));
  });

  test('Should return left with weak password failure when password is null', () async {
    final result = await useCase.call(RegisterParams(
        email: "email@com.br",
        password: null,
        name: "name"
    ));

    expect(result, Left(WeakPasswordFailure(
        title: genericErrorMessageTitle,
        message: weakPassword
    )));
  });

  test('Should return left with weak password failure when password is less than 6 digits', () async {
    final result = await useCase.call(RegisterParams(
        email: "email@com.br",
        password: "12345",
        name: "name"
    ));

    expect(result, Left(WeakPasswordFailure(
        title: genericErrorMessageTitle,
        message: weakPassword
    )));
  });

  test('Should call register with provided parameters', () async {
    when(repository.register(any)).thenAnswer((_) async => null);

    await useCase.call(RegisterParams(
        email: "email@com.br",
        password: "1234567",
        name: "name"
    ));

    verify(repository.register(UserRegisterData(
        email: "email@com.br",
        password: "1234567",
        name: "name"
    ))).called(1);
  });

  test('Should return left with failure when call to register fails', () async {
    when(repository.register(any)).thenAnswer((_) async => Left(GenericFailure(
      message: "message",
      title: "title"
    )));

    final result = await useCase.call(RegisterParams(
        email: "email@com.br",
        password: "123456",
        name: "name"
    ));

    expect(result, Left(GenericFailure(
        message: "message",
        title: "title"
    )));
    verify(repository.register(UserRegisterData(
        email: "email@com.br",
        password: "123456",
        name: "name"
    ))).called(1);
  });
}
