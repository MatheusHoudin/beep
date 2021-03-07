import 'package:beep/core/usecase/base_use_case.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/repository/home/router/home_router_repository.dart';

class HomeRouterUseCase extends BaseUseCase<BeepUser, HomeRouterNoParams> {
  final HomeRouterRepository repository;

  HomeRouterUseCase({this.repository});

  @override
  BeepUser call(HomeRouterNoParams params) {
    return repository.getLoggedInUser();
  }
}

class HomeRouterNoParams {}
