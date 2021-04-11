import 'package:beep/core/error/failure.dart';
import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:beep/core/constants/keys.dart';

class SaveOnboardingDoneUsecase extends AsyncBaseUseCase<void, SaveOnboardingParams> {
  final AppPreferencesRepository _repository;

  SaveOnboardingDoneUsecase([this._repository]);

  @override
  Future<Either<Failure, void>> call(SaveOnboardingParams params) {
    _repository.saveBoolean(onboardingDoneKey, params.value);
  }
}

class SaveOnboardingParams extends Equatable {
  final bool value;

  SaveOnboardingParams({this.value});

  @override
  List<Object> get props => [this.value];
}
