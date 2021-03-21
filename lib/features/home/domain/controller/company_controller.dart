import 'package:beep/features/home/domain/usecase/fetch_company_inventories_use_case.dart';
import 'package:beep/features/home/domain/usecase/format_company_inventories_per_status_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/model/beep_inventory.dart';
import 'package:beep/shared/model/beep_user.dart';
import 'package:beep/shared/model/inventories_per_status.dart';
import 'package:get/get.dart';

abstract class CompanyController extends GetxController {
  String getCompanyName();

  bool isLoadingInventories();

  List<BeepInventory> getStartedInventories();

  List<BeepInventory> getNotStartedInventories();

  List<BeepInventory> getFinishedInventories();

  void fetchCompanyInventories();
}

class CompanyControllerImpl extends CompanyController {
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final FormatCompanyInventoriesPerStatusUseCase
      formatCompanyInventoriesPerStatusUseCase;
  final FetchCompanyInventoriesUseCase fetchCompanyInventoriesUseCase;
  final FeedbackMessageProvider feedbackMessageProvider;

  BeepUser loggedUser;
  Rx<InventoriesPerStatus> inventoriesPerStatus = Rx();
  final isLoading = false.obs;

  CompanyControllerImpl({
    this.getLoggedUserUseCase,
      this.fetchCompanyInventoriesUseCase,
      this.formatCompanyInventoriesPerStatusUseCase,
      this.feedbackMessageProvider
  });

  @override
  String getCompanyName() {
    return loggedUser?.name ?? "";
  }

  void _getLoggedUser() {
    loggedUser = getLoggedUserUseCase(GetLoggedUserParams());
  }

  @override
  void fetchCompanyInventories() async {
    _getLoggedUser();
    isLoading.value = true;

    final inventoriesPerStatusResult = await fetchCompanyInventoriesUseCase
        .call(FetchCompanyInventoriesParams(companyCode: loggedUser.companyCode));

    isLoading.value = false;
    inventoriesPerStatusResult.fold(
      (failure) {
        feedbackMessageProvider.showOneButtonDialog(
          failure.title,
          failure.message
        );
        update();
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

  @override
  List<BeepInventory> getFinishedInventories() {
    return inventoriesPerStatus?.value?.finishedInventories;
  }

  @override
  List<BeepInventory> getNotStartedInventories() {
    return inventoriesPerStatus?.value?.notStartedInventories;
  }

  @override
  List<BeepInventory> getStartedInventories() {
    return inventoriesPerStatus?.value?.startedInventories;
  }

  @override
  bool isLoadingInventories() {
    return isLoading.value;
  }
}
