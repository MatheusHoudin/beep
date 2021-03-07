import 'package:beep/core/constants/keys.dart';
import 'package:beep/core/constants/routes.dart';
import 'package:beep/core/di/login_page_bindings.dart';
import 'package:beep/core/di/main_bindings.dart';
import 'package:beep/core/di/register_page_bindings.dart';
import 'package:beep/core/di/splash_page_bindings.dart';
import 'package:beep/features/home/presentation/home_router.dart';
import 'package:beep/features/login/presentation/pages/login_page.dart';
import 'package:beep/features/register/presentation/register_page.dart';
import 'package:beep/features/splash/presentation/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var sharedPreferencesInstance = await SharedPreferences.getInstance();
  var shouldHideOnboarding =
      sharedPreferencesInstance.getBool(onboardingDoneKey);

  Get.put<SharedPreferences>(sharedPreferencesInstance);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: getInitialRoute(shouldHideOnboarding),
    initialBinding: MainBinding(),
    getPages: [
      GetPage(
        name: splashPage,
        page: () => SplashPage(),
        binding: SplashPageBinding()),
      GetPage(
        name: loginPage,
        page: () => LoginPage(),
        binding: LoginPageBinding()),
      GetPage(
        name: registerPage,
        page: () => RegisterPage(),
        transition: Transition.downToUp,
        binding: RegisterPageBinding()
      ),
      GetPage(
        name: homeRouterPage,
        page: () => HomeRouter(),
        transition: Transition.rightToLeft
      )
    ],
  ));
}

String getInitialRoute(bool shouldHideOnboarding) {
  return (shouldHideOnboarding != null && shouldHideOnboarding)
      ? loginPage
      : splashPage;
}
