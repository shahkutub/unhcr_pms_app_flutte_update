import 'package:get/get.dart';

import '../controllers/after_login_controller.dart';
import '../controllers/login_controller.dart';

class AfterLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<after_login_controller>(
      () => after_login_controller(),
    );
  }
}
