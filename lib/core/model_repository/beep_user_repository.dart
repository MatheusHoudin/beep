import 'package:beep/shared/model/beep_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BeepUserRepository {
  Future<BeepUser> fetchUserById(String userId);
  Future registerUser(String userId, String name, String email);
}

class BeepUserRepositoryImpl extends BeepUserRepository {
  final FirebaseFirestore firestore;

  BeepUserRepositoryImpl({this.firestore});

  @override
  Future<BeepUser> fetchUserById(String userId) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('id', isEqualTo: userId)
          .limit(1)
          .get();

      Map<String, dynamic> beepUserJson = snapshot.docs.first.data();

      return BeepUser.fromJson(beepUserJson);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future registerUser(String userId, String name, String email) {
    try {
      firestore.collection('users').add({
        'id': userId,
        'name': name,
        'email': email,
        'type': 'normal'
      });
    } catch (e) {
      throw e;
    }
  }

}
