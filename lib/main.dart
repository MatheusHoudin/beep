import 'package:beep/core/constants/keys.dart';
import 'package:beep/core/constants/routes.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/di/create_inventory_page_bindings.dart';
import 'package:beep/core/di/home_page_bindings.dart';
import 'package:beep/core/di/login_page_bindings.dart';
import 'package:beep/core/di/main_bindings.dart';
import 'package:beep/core/di/register_page_bindings.dart';
import 'package:beep/core/di/splash_page_bindings.dart';
import 'package:beep/features/createinventory/presentation/create_inventory_page.dart';
import 'package:beep/features/home/presentation/router/home_router.dart';
import 'package:beep/features/inventorydetails/presentation/inventory_details_page.dart';
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
  final loggedUserId = sharedPreferencesInstance.getString(userIdKey);

  Get.put<SharedPreferences>(sharedPreferencesInstance);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: getInitialRoute(shouldHideOnboarding, loggedUserId),
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
        transition: Transition.rightToLeft,
        binding: HomePageBinding()
      ),
      GetPage(
        name: createInventoryRouterPage,
        page: () => CreateInventoryPage(),
        binding: CreateInventoryPageBindings()
      ),
      GetPage(
        name: inventoryDetailsRouterPage,
        page: () => InventoryDetailsPage()
      )
    ],
  ));
}

String getInitialRoute(bool shouldHideOnboarding, String loggedUserId) {
  if (loggedUserId != null) return homeRouterPage;
  return (shouldHideOnboarding != null && shouldHideOnboarding)
      ? loginPage
      : splashPage;
}
