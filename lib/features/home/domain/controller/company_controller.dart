import 'package:beep/features/home/domain/usecase/fetch_company_inventories_use_case.dart';
import 'package:beep/features/home/domain/usecase/format_company_inventories_per_status_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventories_per_status.dart';
import 'package:get/get.dart';

abstract class CompanyController extends GetxController {
  void getLoggedUser();

  String getCompanyName();

  InventoriesPerStatus getInventoriesPerStatus();

  void fetchCompanyInventories();
}

class CompanyControllerImpl extends CompanyController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final FormatCompanyInventoriesPerStatusUseCase
      formatCompanyInventoriesPerStatusUseCase;
  final FetchCompanyInventoriesUseCase fetchCompanyInventoriesUseCase;
  final LoadingProvider loadingProvider;
  final FeedbackMessageProvider feedbackMessageProvider;

  BeepUser loggedUser;
  Rx<InventoriesPerStatus> inventoriesPerStatus;

  CompanyControllerImpl(
      {this.getLoggedUserUseCase,
      this.fetchCompanyInventoriesUseCase,
      this.formatCompanyInventoriesPerStatusUseCase,
      this.loadingProvider,
      this.feedbackMessageProvider});

  @override
  String getCompanyName() {
    return loggedUser?.name ?? "";
  }

  @override
  void getLoggedUser() {
    loggedUser = getLoggedUserUseCase(GetLoggedUserParams());
    update();
  }

  @override
  void fetchCompanyInventories() async {
    loadingProvider.showFullscreenLoading();

    final inventoriesPerStatusResult = await fetchCompanyInventoriesUseCase
        .call(FetchCompanyInventoriesParams(companyCode: loggedUser.companyCode));

    loadingProvider.hideFullscreenLoading();
    inventoriesPerStatusResult.fold(
      (failure) {
        feedbackMessageProvider.showOneButtonDialog(
          failure.title,
          failure.message
        );
      },
      (companyInventories) {
        inventoriesPerStatus.value = formatCompanyInventoriesPerStatusUseCase.call(companyInventories);
        update();
      }
    );
  }

  @override
  InventoriesPerStatus getInventoriesPerStatus() {
    return inventoriesPerStatus?.value;
  }
}
