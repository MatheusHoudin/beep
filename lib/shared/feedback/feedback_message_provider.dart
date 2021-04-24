import 'package:beep/shared/widgets/one_button_dialog.dart';
import 'package:get/get.dart';

abstract class FeedbackMessageProvider {
  void showOneButtonDialog(String title, String message, {Function okFunction});
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
}
