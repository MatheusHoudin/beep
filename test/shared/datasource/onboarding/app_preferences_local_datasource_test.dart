import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  AppPreferencesLocalDataSource appPreferencesLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    appPreferencesLocalDataSource = AppPreferencesLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences
    );
  });
  
  test('Should get boolean with provided key', () {
    when(mockSharedPreferences.getBool(any)).thenReturn(true);
    
    var boolResult = appPreferencesLocalDataSource.getBoolean("key");

    expect(true, boolResult);
    verify(mockSharedPreferences.getBool("key"));
  });

  test('Should save boolean with provided key and value', () {
    when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async => true);

    appPreferencesLocalDataSource.saveBoolean("key", false);

    verify(mockSharedPreferences.setBool("key", false));
  });
}  
