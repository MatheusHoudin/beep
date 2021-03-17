import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';

abstract class AppPreferencesRepository {
  Future<bool> saveBoolean(String key, bool value);
  Future<bool> saveString(String key, String value);
  bool getBoolean(String key);
  String getString(String key);
}

class AppPreferencesRepositoryImpl extends AppPreferencesRepository {
  final AppPreferencesLocalDataSource localDataSource;

  AppPreferencesRepositoryImpl({this.localDataSource});

  @override
  bool getBoolean(String key) {
    return localDataSource.getBoolean(key);
  }

  @override
  Future<bool> saveBoolean(String key, bool value) {
    return localDataSource.saveBoolean(key, value);
  }

  @override
  String getString(String key) {
    return localDataSource.getString(key);
  }

  @override
  Future<bool> saveString(String key, String value) {
    return localDataSource.saveString(key, value);
  }
}
