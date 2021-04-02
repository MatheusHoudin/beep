import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/model/beep_user.dart';

abstract class GetLoggedUserRepository {
  BeepUser getLoggedInUser();
}

class GetLoggedUserRepositoryImpl extends GetLoggedUserRepository {
  final UserLocalDataSource dataSource;

  GetLoggedUserRepositoryImpl({this.dataSource});

  @override
  BeepUser getLoggedInUser() {
    return dataSource.getLoggedUser();
  }
}
