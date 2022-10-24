

import 'package:brac_arna/app/modules/current_stock/current_stock_controller.dart';
import 'package:brac_arna/app/modules/stock_receive/stock_receive_controller.dart';
import 'package:get/get.dart';


class StockReceiveBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StockReceiveController>(
          () => StockReceiveController(),
    );
  }
}