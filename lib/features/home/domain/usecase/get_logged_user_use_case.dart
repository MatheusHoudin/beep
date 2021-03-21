import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/repository/home/get_logged_user_repository.dart';

class GetLoggedUserUseCase extends BaseUseCase<BeepUser, GetLoggedUserParams> {
  final GetLoggedUserRepository repository;

  GetLoggedUserUseCase({this.repository});

  @override
  BeepUser call(GetLoggedUserParams params) {
    return repository.getLoggedInUser();
  }
}

class GetLoggedUserParams {}
