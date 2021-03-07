import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/core/model_repository/beep_user_repository.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRemoteDataSource {
  Future<void> registerUser(UserRegisterData userRegisterData);
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final AuthRepository authRepository;
  final BeepUserRepository beepUserRepository;

  RegisterRemoteDataSourceImpl({this.authRepository, this.beepUserRepository});

  @override
  Future<void> registerUser(UserRegisterData userRegisterData) async {
    try {
      final userId = await authRepository.createAccount(userRegisterData.email, userRegisterData.password);

      await beepUserRepository.registerUser(userId, userRegisterData.name, userRegisterData.email);

    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'invalid-password': throw WeakPasswordException();
        case 'email-already-in-use': throw EmailAlreadyInUseException();
        case 'invalid-email': throw InvalidEmailException();
      }
    } on Exception {
      throw GenericException();
    }
  }
}
