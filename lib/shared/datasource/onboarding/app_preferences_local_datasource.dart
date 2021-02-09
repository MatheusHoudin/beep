import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreferencesLocalDataSource {
  void saveBoolean(String key, bool value);
  bool getBoolean(String key);
}

class AppPreferencesLocalDataSourceImpl extends AppPreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  AppPreferencesLocalDataSourceImpl({this.sharedPreferences});

  @override
  bool getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  @override
  void saveBoolean(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }
}
