import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_user_repository.dart';
import 'package:beep/shared/datasource/login/login_remote_data_source.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}
class BeepUserRepositoryMock extends Mock implements BeepUserRepository {}
class FirebaseAuthExceptionMock extends Mock implements FirebaseAuthException {}

void main() {
  AuthRepositoryMock authRepositoryMock;
  BeepUserRepositoryMock beepUserRepositoryMock;
  LoginRemoteDataSource remoteDataSource;
  FirebaseAuthExceptionMock exceptionMock;

  setUp(() {
    exceptionMock = FirebaseAuthExceptionMock();
    beepUserRepositoryMock = BeepUserRepositoryMock();
    authRepositoryMock = AuthRepositoryMock();
    remoteDataSource = LoginRemoteDataSourceImpl(
      beepUserRepository: beepUserRepositoryMock,
      authRepository: authRepositoryMock
    );
  });

  test('Should throw UserNotFoundException when call to log in and fetch user id and password throws user not found error', () {
    when(exceptionMock.code).thenReturn('user-not-found');
    when(authRepositoryMock.logInAndFetchUserId(any, any)).thenThrow(exceptionMock);

    final call = remoteDataSource.login;

    expect(() => call("email", "password"), throwsA(TypeMatcher<UserNotFoundException>()));
    verify(authRepositoryMock.logInAndFetchUserId("email", "password"));
  });

  test('Should throw WrongPasswordException when call to sign in with email and password throws wrong password error', () {
    when(exceptionMock.code).thenReturn('wrong-password');
    when(authRepositoryMock.logInAndFetchUserId(any, any)).thenThrow(exceptionMock);

    final call = remoteDataSource.login;

    expect(() => call("email", "password"), throwsA(TypeMatcher<WrongPasswordException>()));
    verify(authRepositoryMock.logInAndFetchUserId("email", "password"));
  });

  test('Should throw InvalidEmailException when call to sign in with email and password throws invalid email error', () {
    when(exceptionMock.code).thenReturn('invalid-email');
    when(authRepositoryMock.logInAndFetchUserId(any, any)).thenThrow(exceptionMock);

    final call = remoteDataSource.login;

    expect(() => call("email", "password"), throwsA(TypeMatcher<InvalidEmailException>()));
    verify(authRepositoryMock.logInAndFetchUserId("email", "password"));
  });

  test('Should throw generic exception when call to log in and fetch user is successful but call to fetch user by id throws an exception', () {
    when(authRepositoryMock.logInAndFetchUserId(any, any)).thenAnswer((_) async => "id");
    when(beepUserRepositoryMock.fetchUserById(any)).thenThrow(Exception());

    final call = remoteDataSource.login;

    expect(() async => await call("email", "password"), throwsA(TypeMatcher<GenericException>()));
    verify(authRepositoryMock.logInAndFetchUserId("email", "password"));
  });

  test('Should return beep user when call to login and fetch user id and fetch user by id is successful', () async {
    final beepUser = BeepUser();
    when(authRepositoryMock.logInAndFetchUserId(any, any)).thenAnswer((_) async => "id");
    when(beepUserRepositoryMock.fetchUserById(any)).thenAnswer((_) async => beepUser);

    final result = await remoteDataSource.login("email", "password");

    expect(result, beepUser);
    verify(authRepositoryMock.logInAndFetchUserId("email", "password"));
    verify(beepUserRepositoryMock.fetchUserById("id"));
  });
}
