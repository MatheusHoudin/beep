import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/exception.dart';
import 'package:beep/shared/model/user_register_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterRemoteDataSource {
  Future<void> registerUser(UserRegisterData userRegisterData);
}

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  RegisterRemoteDataSourceImpl({this.auth, this.firestore});

  @override
  Future<void> registerUser(UserRegisterData userRegisterData) async {
    try {
      final userCredentials = await auth.createUserWithEmailAndPassword(
          email: userRegisterData.email,
          password: userRegisterData.password
      );

      final userId = userCredentials.credential.providerId;

      await firestore.collection('users').add({
        'id': userId,
        'name': userRegisterData.name,
        'email': userRegisterData.email
      });

    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case 'invalid-password': throw WeakPasswordException();
        case 'email-already-in-use': throw EmailAlreadyInUseException();
      }
    } on Exception {
      throw GenericException(message: genericErrorMessage);
    }
  }
}
