import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/shared/datasource/register/register_remote_data_source.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:beep/shared/repository/register/register_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class NetworkInfoMock extends Mock implements NetworkInfo {}

class RegisterRemoteDataSourceMock extends Mock implements RegisterRemoteDataSource {}

void main() {
  NetworkInfoMock networkInfo;
  RegisterRemoteDataSourceMock dataSource;

  RegisterRepository repository;

  setUp(() {
    networkInfo = NetworkInfoMock();
    dataSource = RegisterRemoteDataSourceMock();

    repository = RegisterRepositoryImpl(
      networkInfo: networkInfo,
      remoteDataSource: dataSource
    );
  });

  group('no internet connection', () {

    test('Should return Left with NoInternetConnectionFailure when there is no internet connection', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.register(UserRegisterData());

      expect(result, Left(NoInternetConnectionFailure()));
    });

  });

  group('there is internet connection', () {

    test('Should call register user with provided user register data', () async {
      final userRegisterData = UserRegisterData(
        name: "name",
        password: "password",
        email: "email"
      );
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.registerUser(any)).thenAnswer((_) => null);

      await repository.register(userRegisterData);

      verify(networkInfo.isConnected).called(1);
      verify(dataSource.registerUser(userRegisterData)).called(1);
    });

    test('Should return a left with weak password failure when data source throws weak password exception', () async {
      when(dataSource.registerUser(any)).thenThrow(WeakPasswordException());
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.register(UserRegisterData());

      verify(networkInfo.isConnected).called(1);
      expect(result, Left(WeakPasswordFailure(
        title: genericErrorMessageTitle,
        message: weakPassword
      )));
    });

    test('Should return a left with email already in use failure when data source throws email already in use exception', () async {
      when(dataSource.registerUser(any)).thenThrow(EmailAlreadyInUseException());
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.register(UserRegisterData());

      verify(networkInfo.isConnected).called(1);
      expect(result, Left(EmailAlreadyInUseFailure(
        title: genericErrorMessageTitle,
        message: emailAlreadyInUse
      )));
    });

    test('Should return a left with invalid email failure when data source throws an invalid email exception', () async {
      when(dataSource.registerUser(any)).thenThrow(InvalidEmailException());
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.register(UserRegisterData());

      verify(networkInfo.isConnected).called(1);
      expect(result, Left(InvalidEmailFailure(
          title: genericErrorMessageTitle,
          message: invalidEmail
      )));
    });

    test('Should return a left with generic failure failure when data source throws generic exception', () async {
      when(dataSource.registerUser(any)).thenThrow(GenericException());
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      final result = await repository.register(UserRegisterData());

      verify(networkInfo.isConnected).called(1);
      expect(result, Left(GenericFailure(
        title: genericErrorMessageTitle,
        message: genericErrorMessage
      )));
    });
  });
}
