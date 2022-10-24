

import 'package:get/get.dart';

import '../controllers/internal_request_controller.dart';


class InternalRequestBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InternalRequestController>(
          () => InternalRequestController(),
    );
  }
}