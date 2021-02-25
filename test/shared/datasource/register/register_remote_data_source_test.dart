import 'package:beep/core/error/exception.dart';
import 'package:beep/shared/datasource/register/register_remote_data_source.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class UserCredentialMock extends Mock implements UserCredential {}

class AuthCredentialMock extends Mock implements AuthCredential {}

class CollectionReferenceMock extends Mock implements CollectionReference {}

class FirebaseAuthExceptionMock extends Mock implements FirebaseAuthException {}

void main() {
  FirebaseAuthMock auth;
  FirebaseFirestoreMock firestore;
  UserCredentialMock userCredential;
  AuthCredentialMock authCredentialMock;
  CollectionReferenceMock collectionReferenceMock;
  FirebaseAuthExceptionMock firebaseAuthExceptionMock;

  RegisterRemoteDataSource registerRemoteDataSource;

  setUp(() {
    auth = FirebaseAuthMock();
    firestore = FirebaseFirestoreMock();
    userCredential = UserCredentialMock();
    authCredentialMock = AuthCredentialMock();
    collectionReferenceMock = CollectionReferenceMock();
    firebaseAuthExceptionMock = FirebaseAuthExceptionMock();

    registerRemoteDataSource =
        RegisterRemoteDataSourceImpl(auth: auth, firestore: firestore);
  });

  test('Should create user with email and password and save user data',
          () async {
        when(userCredential.credential).thenReturn(authCredentialMock);
        when(authCredentialMock.providerId).thenReturn("id");
        when(auth.createUserWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
            .thenAnswer((_) async => userCredential);
        when(firestore.collection(any)).thenReturn(collectionReferenceMock);
        when(collectionReferenceMock.add(any)).thenAnswer((_) async => null);

        await registerRemoteDataSource.registerUser(UserRegisterData(
            name: "name", email: "email", password: "password"));

        verify(userCredential.credential).called(1);
        verify(authCredentialMock.providerId).called(1);
        verify(auth.createUserWithEmailAndPassword(
            email: "email", password: "password"))
            .called(1);
        verify(firestore.collection('users')).called(1);
        verify(collectionReferenceMock
            .add({'id': 'id', 'name': 'name', 'email': 'email'}))
            .called(1);
      });

  test(
      'Should throw a weak password exception when call to create user with email and password throws invalid-password error',
          () async {
        when(auth.createUserWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(firebaseAuthExceptionMock);
        when(firebaseAuthExceptionMock.code).thenReturn('invalid-password');

        final call = registerRemoteDataSource.registerUser;

        expect(() =>
            call(UserRegisterData(
                name: "name",
                email: "email",
                password: "password")), throwsA(TypeMatcher<WeakPasswordException>()));
        verify(auth.createUserWithEmailAndPassword(
            email: "email", password: "password"))
            .called(1);
      });

  test(
      'Should throw a email already in use exception when call to create user with email and password throws email-already-in-use error',
          () async {
        when(auth.createUserWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(firebaseAuthExceptionMock);
        when(firebaseAuthExceptionMock.code).thenReturn('email-already-in-use');

        final call = registerRemoteDataSource.registerUser;

        expect(() =>
            call(UserRegisterData(
                name: "name",
                email: "email",
                password: "password")), throwsA(TypeMatcher<EmailAlreadyInUseException>()));
        verify(auth.createUserWithEmailAndPassword(
            email: "email", password: "password"))
            .called(1);
      });

  test(
      'Should throw a generic exception exception when call to create user with email and password throws exception',
          () async {
        when(auth.createUserWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(Exception());

        final call = registerRemoteDataSource.registerUser;

        expect(() =>
            call(UserRegisterData(
                name: "name",
                email: "email",
                password: "password")), throwsA(TypeMatcher<GenericException>()));
        verify(auth.createUserWithEmailAndPassword(
            email: "email", password: "password"))
            .called(1);
      });
}
