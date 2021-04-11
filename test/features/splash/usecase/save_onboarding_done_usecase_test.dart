
import 'package:beep/core/constants/keys.dart';
import 'package:beep/features/splash/domain/usecase/save_onboarding_done_usecase.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAppPreferencesRepository extends Mock implements AppPreferencesRepository {}

void main() {
  MockAppPreferencesRepository mockAppPreferencesRepository;
  SaveOnboardingDoneUsecase saveOnboardingDoneUsecase;

  setUp(() {
    mockAppPreferencesRepository = MockAppPreferencesRepository();
    saveOnboardingDoneUsecase = SaveOnboardingDoneUsecase(mockAppPreferencesRepository);
  });

  test('Should save boolean with key and provided value', () {
    when(mockAppPreferencesRepository.saveBoolean(any, any)).thenAnswer((_) {});

    saveOnboardingDoneUsecase.call(SaveOnboardingParams(value: true));

    verify(mockAppPreferencesRepository.saveBoolean(onboardingDoneKey, true));
  });
}
