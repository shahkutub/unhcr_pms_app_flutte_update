

import 'package:brac_arna/app/modules/consumption_tally/controllers/consumption_tally_controller.dart';
import 'package:get/get.dart';


class ConsumptionTallyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ConsumptionTallyController>(
          () => ConsumptionTallyController(),
    );
  }
}