

import 'package:get/get.dart';

import '../controllers/item_dispatch_controller.dart';

class ItemDispatchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ItemDispatchController>(
          () => ItemDispatchController(),
    );
  }
}