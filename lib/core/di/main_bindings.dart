import 'package:beep/core/auth_repository/auth_repository.dart';
import 'package:beep/core/model_repository/beep_user_repository.dart';
import 'package:beep/core/network/network_info.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/shared/datasource/onboarding/app_preferences_local_datasource.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:beep/shared/repository/onboarding/app_preferences_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put<AppPreferencesLocalDataSource>(
        AppPreferencesLocalDataSourceImpl(sharedPreferences: Get.find()));
    Get.put<AppPreferencesRepository>(
        AppPreferencesRepositoryImpl(localDataSource: Get.find()));
    Get.put<AppRouter>(AppRouterImpl());
    Get.put<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()));
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.put<BeepUserRepository>(
        BeepUserRepositoryImpl(firestore: FirebaseFirestore.instance));
    Get.put<AuthRepository>(AuthRepositoryImpl(auth: FirebaseAuth.instance));
    Get.put<FeedbackMessageProvider>(FeedbackMessageProviderImpl());
    Get.put<LoadingProvider>(LoadingProviderImpl());
  }
}
