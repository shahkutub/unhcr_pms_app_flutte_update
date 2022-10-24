

import 'package:get/get.dart';

import '../controllers/all_dispatch_controller.dart';


class AllDispatchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllDispatchController>(
          () => AllDispatchController(),
    );
  }
}