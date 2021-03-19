import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:get/get.dart';

abstract class CompanyController extends GetxController {
  void getLoggedUser();
  String getCompanyName();
}

class CompanyControllerImpl extends CompanyController {
  final GetLoggedUserUseCase getLoggedUserUseCase;

  BeepUser loggedUser;

  CompanyControllerImpl({this.getLoggedUserUseCase});

  @override
  String getCompanyName() {
    return loggedUser?.name ?? "";
  }

  @override
  void getLoggedUser() {
    loggedUser = getLoggedUserUseCase(GetLoggedUserParams());
    update();
  }
}
