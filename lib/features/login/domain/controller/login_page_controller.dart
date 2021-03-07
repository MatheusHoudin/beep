import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/login/domain/usecase/login_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:get/get.dart';

abstract class LoginPageController extends GetxController {
  bool isPasswordVisible();
  void togglePasswordVisibility();
  void continueToRegisterPage();
  void login(String email, String password);
}

class LoginPageControllerImpl extends LoginPageController {
  final LoginUseCase _loginUseCase;
  final FeedbackMessageProvider _feedbackMessageProvider;
  final LoadingProvider _loadingProvider;
  var _isPasswordVisible = false.obs;

  final AppRouter _router;

  LoginPageControllerImpl([
    this._router, 
    this._loginUseCase,
    this._loadingProvider,
    this._feedbackMessageProvider
  ]);

  @override
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
    update();
  }

  @override
  bool isPasswordVisible() {
    return _isPasswordVisible.value;
  }

  @override
  void continueToRegisterPage() {
    _router.routeLoginPageToRegisterPage();
  }

  @override
  void login(String email, String password) async {
    _loadingProvider.showFullscreenLoading();

    LoginParams params = LoginParams(email: email, password: password);

    final loginResult = await _loginUseCase.call(params);

    _loadingProvider.hideFullscreenLoading();

    if (loginResult != null) {
      loginResult.fold(_handleLoginFailure, null);
    } else {
      _router.routeLoginPageToHomePage();
    }
  }

  void _handleLoginFailure(Failure failure) {
    _feedbackMessageProvider.showOneButtonDialog(
      failure.title,
      failure.message
    );
  }
}
