import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';

abstract class AppPreferencesRepository {
  void saveBoolean(String key, bool value);
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
  void saveBoolean(String key, bool value) {
    localDataSource.saveBoolean(key, value);
  }

  @override
  String getString(String key) {
    localDataSource.getString(key);
  }
}
