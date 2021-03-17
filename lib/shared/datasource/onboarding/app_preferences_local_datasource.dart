import 'package:shared_preferences/shared_preferences.dart';

abstract class AppPreferencesLocalDataSource {
  Future<bool> saveBoolean(String key, bool value);
  Future<bool> saveString(String key, String value);
  bool getBoolean(String key);
  String getString(String key);
}

class AppPreferencesLocalDataSourceImpl extends AppPreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  AppPreferencesLocalDataSourceImpl({this.sharedPreferences});

  @override
  bool getBoolean(String key) {
    return sharedPreferences.getBool(key);
  }

  @override
  Future<bool> saveBoolean(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  @override
  String getString(String key) {
    return sharedPreferences.getString(key);
  }

  @override
  Future<bool> saveString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }
}
