import 'package:beep/core/constants/routes.dart';
import 'package:beep/core/di/main_bindings.dart';
import 'package:beep/core/di/splash_screen_bindings.dart';
import 'package:beep/features/login/presentation/pages/login_page.dart';
import 'package:beep/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: splashScreen,
    initialBinding: MainBinding(),
    getPages: [
      GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        binding: SplashScreenBinding()
      ),
      GetPage(
        name: loginScreen,
        page: () => LoginPage()
      )
    ],
  ));
}
