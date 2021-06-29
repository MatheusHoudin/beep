import 'package:beep/shared/widgets/one_button_dialog.dart';
import 'package:beep/shared/widgets/two_buttons_dialog.dart';
import 'package:get/get.dart';

abstract class FeedbackMessageProvider {
  void showOneButtonDialog(String title, String message, {Function okFunction});
  void showTwoButtonsDialog(String title, String message, String cancelText, String confirmText,
      Function confirmFunction, Function cancelFunction);
}

class FeedbackMessageProviderImpl extends FeedbackMessageProvider {
  @override
  void showOneButtonDialog(String title, String message, {Function okFunction}) {
    Get.dialog(OneButtonDialog(
      title: title,
      message: message,
      okFunction: okFunction ?? Get.back,
    ));
  }

  @override
  void showTwoButtonsDialog(String title, String message, String cancelText, String confirmText,
      Function confirmFunction, Function cancelFunction) {
    Get.dialog(TwoButtonsDialog(
      title: title,
      message: message,
      cancelText: cancelText,
      confirmText: confirmText,
      confirmFunction: confirmFunction,
      cancelFunction: cancelFunction
    ));
  }
}
