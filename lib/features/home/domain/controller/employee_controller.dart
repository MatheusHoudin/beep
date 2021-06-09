import 'package:beep/features/home/domain/usecase/format_company_inventories_per_status_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:get/get.dart';

abstract class EmployeeController extends GetxController {
  void initialize();
  void fetchEmployeeInventories();
  String getLoggedUserName();
}

class EmployeeControllerImpl extends EmployeeController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final FormatCompanyInventoriesPerStatusUseCase formatCompanyInventoriesPerStatusUseCase;

  BeepUser _beepUser;

  EmployeeControllerImpl({this.getLoggedUserUseCase, this.formatCompanyInventoriesPerStatusUseCase});

  @override
  void initialize() {
    _beepUser = getLoggedUserUseCase(GetLoggedUserParams());
  }

  @override
  void fetchEmployeeInventories() {
    
  }

  @override
  String getLoggedUserName() {
    return _beepUser?.name ?? "";
  }
}
