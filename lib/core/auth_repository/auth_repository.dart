import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> logInAndFetchUserId(String email, String password);
  Future<String> createAccount(String email, String password);
  Future logOut();
}

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth auth;

  AuthRepositoryImpl({this.auth});

  @override
  Future<String> logInAndFetchUserId(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user.uid;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<String> createAccount(String email, String password) async {
    try {
      final userCredentials = await auth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredentials.user.uid;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future logOut() async {
    try {
      await auth.signOut();
    } catch (_) {}
  }
}
