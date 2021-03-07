import 'dart:async';

import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_user_repository.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRemoteDataSource {
  Future<BeepUser> login(String email, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final AuthRepository authRepository;
  final BeepUserRepository beepUserRepository;

  LoginRemoteDataSourceImpl({this.authRepository, this.beepUserRepository});

  @override
  Future<BeepUser> login(String email, String password) async{
    try {
      final userId = await authRepository
          .logInAndFetchUserId(email,password);

      return await beepUserRepository.fetchUserById(userId);
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'user-not-found': throw UserNotFoundException();
        case 'wrong-password': throw WrongPasswordException();
        case 'invalid-email': throw InvalidEmailException();
      }
    } on Exception {
      throw GenericException();
    }
  }
}
