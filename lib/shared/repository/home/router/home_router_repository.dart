import 'package:beep/shared/datasource/home/router/home_router_local_datasource.dart';
import 'package:beep/shared/model/beep_user.dart';

abstract class HomeRouterRepository {
  BeepUser getLoggedInUser();
}

class HomeRouterRepositoryImpl extends HomeRouterRepository {
  final HomeRouterLocalDataSource dataSource;

  HomeRouterRepositoryImpl({this.dataSource});

  @override
  BeepUser getLoggedInUser() {
    return dataSource.getLoggedUser();
  }
}
