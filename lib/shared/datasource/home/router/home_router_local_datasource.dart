import 'package:beep/core/constants/texts.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRouterLocalDataSource {
  BeepUser getLoggedUser();
}

class HomeRouterLocalDataSourceImpl extends HomeRouterLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeRouterLocalDataSourceImpl({this.sharedPreferences});

  @override
  BeepUser getLoggedUser() {
    return BeepUser(
      uid: sharedPreferences.getString(userIdKey),
      name: sharedPreferences.getString(userNameKey),
      email: sharedPreferences.getString(userEmailKey),
      type: sharedPreferences.getString(userTypeKey)
    );
  }
}
