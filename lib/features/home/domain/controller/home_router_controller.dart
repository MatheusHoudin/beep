import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/features/home/domain/usecase/logout_use_case.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:get/get.dart';

abstract class HomeRouterController extends GetxController {
  void setStartPage();
  void logOut();
  String currentStartPage();
}

class HomeRouterControllerImpl extends HomeRouterController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final LogOutUseCase logOutUseCase;
  final LoadingProvider loadingProvider;
  final AppRouter router;

  var _startPage = "".obs;
  BeepUser _loggedUser;

  HomeRouterControllerImpl({this.getLoggedUserUseCase, this.logOutUseCase, this.loadingProvider, this.router});

  @override
  String currentStartPage() {
    return _startPage.value;
  }

  @override
  void setStartPage() {
    _loggedUser = getLoggedUserUseCase.call(GetLoggedUserParams());
    _startPage.value = _loggedUser.type;
    update();
  }

  @override
  void logOut() async {
    loadingProvider.showFullscreenLoading();

    await logOutUseCase(LogOutParams());

    loadingProvider.hideFullscreenLoading();
    router.logOut();
  }
}
