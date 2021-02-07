import 'package:beep/core/constants/routes.dart';
import 'package:beep/core/di/splash_screen_bindings.dart';
import 'package:beep/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: splashScreen,
    getPages: [
      GetPage(
        name: splashScreen,
        page: () => SplashScreen(),
        binding: SplashScreenBinding()
      )
    ],
  ));
}
