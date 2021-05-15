import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/features/home/domain/controller/company_controller.dart';
import 'package:beep/features/home/domain/controller/home_router_controller.dart';
import 'package:beep/features/home/domain/usecase/fetch_company_inventories_use_case.dart';
import 'package:beep/features/home/domain/usecase/format_company_inventories_per_status_use_case.dart';
import 'package:beep/features/home/domain/usecase/get_logged_user_use_case.dart';
import 'package:beep/features/home/domain/usecase/logout_use_case.dart';
import 'package:beep/shared/datasource/listinventory/fetch_company_inventories_remote_data_source.dart';
import 'package:beep/shared/datasource/user/user_local_datasource.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/repository/home/get_logged_user_repository.dart';
import 'package:beep/shared/repository/home/logout_user_repository.dart';
import 'package:beep/shared/repository/listinventory/fetch_company_inventories_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuth>(FirebaseAuth.instance);
    Get.put<AuthRepository>(AuthRepositoryImpl(auth: Get.find()));
    Get.put<BeepInventoryRepository>(
        BeepInventoryRepositoryImpl(
          firestore: FirebaseFirestore.instance,
        ),
        permanent: true);
    Get.put<FeedbackMessageProvider>(FeedbackMessageProviderImpl(), permanent: true);
    Get.put<LoadingProvider>(LoadingProviderImpl(), permanent: true);
    Get.put<FetchCompanyInventoriesRemoteDataSource>(
        FetchCompanyInventoriesRemoteDataSourceImpl(repository: Get.find()));
    Get.put<UserLocalDataSource>(UserLocalDataSourceImpl(sharedPreferences: Get.find()));
    Get.put<FetchCompanyInventoriesRepository>(
        FetchCompanyInventoriesRepositoryImpl(networkInfo: Get.find(), remoteDataSource: Get.find()));
    Get.put<GetLoggedUserRepository>(GetLoggedUserRepositoryImpl(dataSource: Get.find()));
    Get.put<LogOutUserRepository>(
        LogOutUserRepositoryImpl(authRepository: Get.find(), userLocalDataSource: Get.find()));
    Get.put<LogOutUseCase>(LogOutUseCase(repository: Get.find()));
    Get.put<GetLoggedUserUseCase>(GetLoggedUserUseCase(repository: Get.find()));
    Get.put<FetchCompanyInventoriesUseCase>(FetchCompanyInventoriesUseCase(repository: Get.find()));
    Get.put<FormatCompanyInventoriesPerStatusUseCase>(FormatCompanyInventoriesPerStatusUseCase());
    Get.put<HomeRouterController>(HomeRouterControllerImpl(
        getLoggedUserUseCase: Get.find(), loadingProvider: Get.find(), logOutUseCase: Get.find(), router: Get.find()));
    Get.put<CompanyController>(CompanyControllerImpl(
        getLoggedUserUseCase: Get.find(),
        feedbackMessageProvider: Get.find(),
        fetchCompanyInventoriesUseCase: Get.find(),
        formatCompanyInventoriesPerStatusUseCase: Get.find(),
        router: Get.find()));
  }
}
