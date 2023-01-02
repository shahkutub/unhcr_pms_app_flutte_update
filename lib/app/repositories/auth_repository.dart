import 'dart:convert';

import 'package:brac_arna/app/api_providers/api_manager.dart';
import 'package:brac_arna/app/api_providers/api_url.dart';
import 'package:brac_arna/app/models/user_model.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:get/get.dart';

import '../models/LoginResponseDept.dart';

class AuthRepository {
  ///User Login api call
  Future<LoginResponseDept?> userLogin(UserModel userData) async {
    Map data = {
      'email': userData.userName,
      //'email': "gkf1dept1@unhcr.org",
      'password': userData.password,
      //'password': "Pms@1234",
    };
    APIManager _manager = APIManager();
    var response;
    try {
      response = await _manager.postAPICall(ApiClient.login, data);


      print('response: ${response}');

      // if(response.statusCode == 500){
      //   print('response: ${'500'}');
      //   //logout();
      //   //Get.offAllNamed(Routes.LOGIN);
      // }

      if (response != null) {


        Get.find<AuthService>().setUser(LoginResponseDept.fromJson(response));
        return LoginResponseDept.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('error:$e');
      return null;
    }
  }


}