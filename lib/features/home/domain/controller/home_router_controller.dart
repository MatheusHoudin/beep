import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:get/get.dart';

abstract class HomeRouterController extends GetxController {
  void setStartPage();
  String currentStartPage();
}

class HomeRouterControllerImpl extends HomeRouterController {
  final GetLoggedUserUseCase useCase;

  var _startPage = "".obs;
  BeepUser _loggedUser;

  HomeRouterControllerImpl({this.useCase});

  @override
  String currentStartPage() {
    return _startPage.value;
  }

  @override
  void setStartPage() {
    _loggedUser = useCase.call(GetLoggedUserParams());
    _startPage.value = _loggedUser.type;
    update();
  }
}
