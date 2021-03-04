import 'package:beep/shared/widgets/one_button_dialog.dart';
import 'package:get/get.dart';

abstract class FeedbackMessageProvider {
  void showOneButtonDialog(String title, String message);
}

class FeedbackMessageProviderImpl extends FeedbackMessageProvider {
  @override
  void showOneButtonDialog(String title, String message) {
    Get.dialog(OneButtonDialog(
      title: title,
      message: message,
      okFunction: Get.back,
    ), barrierDismissible: false);
  }
}
