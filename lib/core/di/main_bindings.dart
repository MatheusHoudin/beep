import 'package:beep/core/network/network_info.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FeedbackMessageProvider>(FeedbackMessageProviderImpl());
    Get.put<LoadingProvider>(LoadingProviderImpl());
    Get.put<AppRouter>(AppRouterImpl());
    Get.put<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()));
    Get.put<FirebaseAuth>(FirebaseAuth.instance);
    Get.put<FirebaseFirestore>(FirebaseFirestore.instance);
  }
}
