

import 'package:brac_arna/app/modules/current_stock/current_stock_controller.dart';
import 'package:get/get.dart';


class CurrentStockBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CurrentStockController>(
          () => CurrentStockController(),
    );
  }
}