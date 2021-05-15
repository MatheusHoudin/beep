import 'package:beep/core/constants/texts.dart';
import 'package:beep/core/error/failure.dart';
import 'package:beep/core/router/app_router.dart';
import 'package:beep/features/register/domain/usecase/register_use_case.dart';
import 'package:beep/shared/feedback/feedback_message_provider.dart';
import 'package:beep/shared/feedback/loading_provider.dart';
import 'package:get/get.dart';

abstract class RegisterController extends GetxController {
  void togglePasswordVisibility();
  bool isPasswordObscure();
  Future registerUser(String name, String email, String password);
}

class RegisterControllerImpl extends RegisterController {

  final AppRouter _router;
  final RegisterUseCase _registerUseCase;
  final FeedbackMessageProvider _feedbackMessageProvider;
  final LoadingProvider _loadingProvider;

  var _isPasswordVisible = false.obs;

  RegisterControllerImpl([
    this._router,
    this._registerUseCase,
    this._feedbackMessageProvider,
    this._loadingProvider
  ]);

  @override
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
    update();
  }

  @override
  Future registerUser(String name, String email, String password) async {
    _loadingProvider.showFullscreenLoading();

    RegisterParams params = RegisterParams(
      name: name,
      email: email,
      password: password
    );

    final registerResult = await _registerUseCase(params);

    _loadingProvider.hideFullscreenLoading();
    if (registerResult != null) {
      registerResult.fold(_handleRegisterFailure, null);
    } else {
      _router.back();
      _feedbackMessageProvider.showOneButtonDialog(
        registerPageRegisterSuccessTitle,
        registerPageRegisterSuccessMessage
      );
    }
  }

  void _handleRegisterFailure(Failure failure) {
    _feedbackMessageProvider.showOneButtonDialog(
      failure.title,
      failure.message
    );
  }

  @override
  bool isPasswordObscure() {
    return _isPasswordVisible.value;
  }
}
