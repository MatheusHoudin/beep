import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/register/domain/controller/register_controller.dart';
import 'package:beep/features/register/domain/usecase/register_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AppRouterMock extends Mock implements AppRouter {}
class RegisterUseCaseMock extends Mock implements RegisterUseCase {}
class FeedbackMessageProviderMock extends Mock implements FeedbackMessageProvider {}
class LoadingProviderMock extends Mock implements LoadingProvider {}

void main() {
  AppRouterMock appRouterMock;
  RegisterUseCaseMock registerUseCaseMock;
  FeedbackMessageProviderMock feedbackMessageProviderMock;
  LoadingProviderMock loadingProviderMock;

  RegisterController registerController;

  setUp(() {
    appRouterMock = AppRouterMock();
    registerUseCaseMock = RegisterUseCaseMock();
    feedbackMessageProviderMock = FeedbackMessageProviderMock();
    loadingProviderMock = LoadingProviderMock();

    registerController = RegisterControllerImpl(
      appRouterMock,
      registerUseCaseMock,
      feedbackMessageProviderMock,
      loadingProviderMock
    );
  });

  test('should set is password visible to false when toggle password visibility is called once', () {
    registerController.togglePasswordVisibility();

    expect(registerController.isPasswordObscure(), false);
  });

  test('should set is password visible to true when toggle password visibility is called twice', () {
    registerController.togglePasswordVisibility();
    registerController.togglePasswordVisibility();

    expect(registerController.isPasswordObscure(), true);
  });

  test('should show a failure message when call to register use case fails', () async {
    when(registerUseCaseMock.call(any)).thenAnswer((_) async => Left(WeakPasswordFailure(
      message: "message",
      title: "title"
    )));

    await registerController.registerUser("name", "email", "password");

    verifyInOrder([
      loadingProviderMock.showFullscreenLoading(),
      registerUseCaseMock.call(RegisterParams(
        name: "name",
        email: "email",
        password: "password"
      )),
      loadingProviderMock.hideFullscreenLoading(),
      feedbackMessageProviderMock.showOneButtonDialog("title", "message")
    ]);
  });

  test('should call back on router and show success message when call to register is successful', () async {
    when(registerUseCaseMock.call(any)).thenAnswer((_) async => null);

    await registerController.registerUser("name", "email", "password");

    verifyInOrder([
      loadingProviderMock.showFullscreenLoading(),
      registerUseCaseMock.call(RegisterParams(
          name: "name",
          email: "email",
          password: "password"
      )),
      loadingProviderMock.hideFullscreenLoading(),
      appRouterMock.back(),
      feedbackMessageProviderMock.showOneButtonDialog(
        registerPageRegisterSuccessTitle,
        registerPageRegisterSuccessMessage
      )
    ]);
  });
}
