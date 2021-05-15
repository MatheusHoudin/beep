import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';

abstract class LogOutUserRepository {
  Future logOutUser();
}

class LogOutUserRepositoryImpl extends LogOutUserRepository {
  final UserLocalDataSource userLocalDataSource;
  final AuthRepository authRepository;

  LogOutUserRepositoryImpl({this.userLocalDataSource, this.authRepository});

  @override
  Future logOutUser() async {
    userLocalDataSource.logout();
    await authRepository.logOut();
  }
}
