import 'dart:async';
import 'dart:convert';

import 'package:brac_arna/app/routes/app_pages.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController
  var userNAme = ''.obs;
  @override
  void onInit() {
    print('called');
    Timer(Duration(seconds: 3), () {
      //userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();

      //print('called: '+userNAme.value);
     // if (Get.find<AuthService>().isAuth) {
      if (Get.find<AuthService>().currentUser.value.data != null) {
        Get.offAllNamed(Routes.AFTER_LOGIN);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
      //Get.offAllNamed(Routes.LOGIN);
      //Get.offAllNamed(Routes.LOGIN);
    });
    super.onInit();
  }



}