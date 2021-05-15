import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/repository/home/logout_user_repository.dart';

class LogOutUseCase extends FutureBaseUseCase<LogOutParams> {
  final LogOutUserRepository repository;

  LogOutUseCase({this.repository});

  @override
  Future call(LogOutParams params) async {
    await repository.logOutUser();
  }
}

class LogOutParams {}
