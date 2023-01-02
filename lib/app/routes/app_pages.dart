import 'package:brac_arna/app/modules/consumption_tally/bindings/consumption_tally_binding.dart';
import 'package:brac_arna/app/modules/consumption_tally/views/consumption_tally_view.dart';
import 'package:brac_arna/app/modules/current_stock/current_stock_binding.dart';
import 'package:brac_arna/app/modules/current_stock/current_stock_view.dart';
import 'package:brac_arna/app/modules/internal_request/bindings/internal_request_submit_binding.dart';
import 'package:brac_arna/app/modules/internal_request/controllers/internal_request_controller.dart';
import 'package:brac_arna/app/modules/internal_request/views/internal_request_submit_view.dart';
import 'package:brac_arna/app/modules/item_dispatch/bindings/all_dispatch_binding.dart';
import 'package:brac_arna/app/modules/item_dispatch/bindings/item_dispatch_binding.dart';
import 'package:brac_arna/app/modules/item_dispatch/views/all_dispatch_view.dart';
import 'package:brac_arna/app/modules/item_dispatch/views/item_dispatch_view.dart';
import 'package:brac_arna/app/modules/login/views/after_login_home_view.dart';


import 'package:get/get.dart';

import 'package:brac_arna/app/modules/login/bindings/login_binding.dart';
import 'package:brac_arna/app/modules/login/views/login_view.dart';

import 'package:brac_arna/app/modules/splashscreen/bindings/splashscreen_binding.dart';
import 'package:brac_arna/app/modules/splashscreen/views/splashscreen_view.dart';

import '../modules/internal_request/bindings/internal_request_binding.dart';
import '../modules/internal_request/views/internal_request_view.dart';
import '../modules/login/bindings/after_login_binding.dart';
import '../modules/stock_receive/stock_receive_binding.dart';
import '../modules/stock_receive/stock_receive_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [

    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.AFTER_LOGIN,
     // page: () => AfterLoginView(),
      page: () => AfterLoginHomeView(),
      binding: AfterLoginBinding(),
    ),







    GetPage(
      name: _Paths.ITEM_DISPATCH,
      page: () => ItemDispatchView(),
      binding: ItemDispatchBinding(),
    ),

    GetPage(
      name: _Paths.CONSUMPTION_TALLY,
      page: () => ConsumptionTallyView(),
      binding: ConsumptionTallyBinding(),
    ),

    GetPage(
      name: _Paths.INTERNAL_REQUEST,
      page: () => InternalRequestView(),
      binding: InternalRequestBinding(),
    ),

     GetPage(
      name: _Paths.INTERNAL_REQUEST_SUBMIT,
      page: () => InternalRequestSubmitView(),
      binding: InternalRequestSubmitBinding(),
    ),


    GetPage(
      name: _Paths.Current_STOCK,
      page: () => CurrentStockView(),
      binding: CurrentStockBinding(),
    ),
    GetPage(
      name: _Paths.All_DISPATCH,
      page: () => AllDispatchView(),
      binding: AllDispatchBinding(),
    ),

    GetPage(
          name: _Paths.STOCK_RECEIVE,
          page: () => StockReceiveView(),
          binding: StockReceiveBinding(),
        ),




  ];
}
