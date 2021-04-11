
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/login/domain/controller/login_page_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AppRouterMock extends Mock implements AppRouter {}

void main() {
  AppRouterMock appRouterMock;
  LoginPageController controller;

  setUp(() {
    appRouterMock = AppRouterMock();
    controller = LoginPageControllerImpl(appRouterMock);
  });

  test('Should return true when toggle password one time', () {
    controller.togglePasswordVisibility();
    final isPasswordVisible = controller.isPasswordVisible();

    expect(isPasswordVisible, true);
  });

  test('Should return false when toggle password twice', () {
    controller.togglePasswordVisibility();
    controller.togglePasswordVisibility();
    final isPasswordVisible = controller.isPasswordVisible();

    expect(isPasswordVisible, false);
  });

  test('Should route to register page', () {
    controller.continueToRegisterPage();

    verify(appRouterMock.routeLoginPageToRegisterPage()).called(1);
  });
}
