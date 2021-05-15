import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  BeepUser getLoggedUser();
  void logout();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({this.sharedPreferences});

  @override
  BeepUser getLoggedUser() {
    return BeepUser(
        uid: sharedPreferences.getString(userIdKey),
        name: sharedPreferences.getString(userNameKey),
        email: sharedPreferences.getString(userEmailKey),
        type: sharedPreferences.getString(userTypeKey),
        companyCode: sharedPreferences.getString(companyCodeKey));
  }

  @override
  void logout() {
    sharedPreferences.setString(userIdKey, '');
    sharedPreferences.setString(userNameKey, '');
    sharedPreferences.setString(userEmailKey, '');
    sharedPreferences.setString(userTypeKey, '');
    sharedPreferences.setString(companyCodeKey, '');
  }
}
