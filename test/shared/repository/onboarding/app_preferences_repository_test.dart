import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAppPreferencesLocalDataSource extends Mock
    implements AppPreferencesLocalDataSource {}

void main() {
  MockAppPreferencesLocalDataSource mockAppPreferencesLocalDataSource;
  AppPreferencesRepository appPreferencesRepository;

  setUp(() {
    mockAppPreferencesLocalDataSource = MockAppPreferencesLocalDataSource();
    appPreferencesRepository = AppPreferencesRepositoryImpl(
        localDataSource: mockAppPreferencesLocalDataSource
    );
  });

  test('Should get boolean from local data source with provided key', () {
    when(mockAppPreferencesLocalDataSource.getBoolean(any)).thenReturn(true);

    var boolResult = appPreferencesRepository.getBoolean("key");

    expect(true, boolResult);
    verify(mockAppPreferencesLocalDataSource.getBoolean("key"));
  });

  test('Should save boolean with provided key and value', () {
    when(mockAppPreferencesLocalDataSource.saveBoolean(any, any)).thenAnswer((_) { });

    appPreferencesRepository.saveBoolean("key", true);

    verify(mockAppPreferencesLocalDataSource.saveBoolean("key", true));
  });
}
