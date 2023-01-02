

import 'package:get/get.dart';

import '../controllers/internal_request_submit_controller.dart';


class InternalRequestSubmitBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InternalRequestSubmitController>(
          () => InternalRequestSubmitController(),
    );
  }
}