import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/model_repository/beep_inventory_repository.dart';
import 'package:beep/core/model_repository/beep_user_repository.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/login/domain/controller/login_page_controller.dart';
import 'package:beep/features/login/domain/usecase/login_use_case.dart';
import 'package:beep/shared/datasource/login/login_remote_data_source.dart';
import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/repository/login/login_repository.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageBinding extends Bindings {

  @override
  void dependencies() async {
    Get.put<AppPreferencesLocalDataSource>(
      AppPreferencesLocalDataSourceImpl(sharedPreferences: Get.find()),
      permanent: true
    );
    Get.put<AppPreferencesRepository>(
      AppPreferencesRepositoryImpl(localDataSource: Get.find()),
      permanent: true
    );
    Get.put<AppRouter>(AppRouterImpl(), permanent: true);
    Get.put<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()), permanent: true);
    Get.put<BeepUserRepository>(
      BeepUserRepositoryImpl(firestore: FirebaseFirestore.instance),
      permanent: true
    );
    Get.put<BeepInventoryRepository>(BeepInventoryRepositoryImpl(
      firestore: FirebaseFirestore.instance,
    ), permanent: true);
    Get.put<AuthRepository>(
      AuthRepositoryImpl(auth: FirebaseAuth.instance),
      permanent: true
    );
    Get.put<FeedbackMessageProvider>(
      FeedbackMessageProviderImpl(),
      permanent: true
    );
    Get.put<LoadingProvider>(
      LoadingProviderImpl(),
      permanent: true
    );
    Get.lazyPut<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl(
      beepUserRepository: Get.find(),
      authRepository: Get.find()
    ));
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(
      networkInfo: Get.find(),
      remoteDataSource: Get.find(),
      preferences: Get.find()
    ));
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(
      loginRepository: Get.find()
    ));
    Get.lazyPut<LoginPageController>(() => LoginPageControllerImpl(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find()
    ));
    await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);
  }
}
