import 'dart:convert';

import 'package:brac_arna/app/api_providers/api_manager.dart';
import 'package:brac_arna/app/api_providers/api_url.dart';
import 'package:brac_arna/app/database_helper/offline_database_helper.dart';
import 'package:brac_arna/app/models/PostResponse.dart';
import 'package:brac_arna/app/models/StockReceiveMedicineListResponse.dart';
import 'package:brac_arna/app/models/StockReceiveResponse.dart';
import 'package:brac_arna/app/models/placeDataModel.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/MedicineListResponse.dart';
import '../models/drug_list_response.dart';
import '../routes/app_pages.dart';

class InformationRepository {
  final dbHelper = DatabaseHelper.instance;

  Future addName(data, _connectionStatus) async {
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    print(data.toString());
    int a = 1;
    print(_connectionStatus.toString());
    try {
      if (_connectionStatus == true) {
        APIManager _manager = APIManager();
        var response;
        var headers = {'Authorization': 'Bearer $token'};

        response = await _manager.postAPICallWithHeader(ApiClient.login, data, headers);
        print('response: ${response}');

        String body = response.statusMessage;
        print(body);
        Map<String, dynamic> row = {
          DatabaseHelper.prodName: data.toString(),
          DatabaseHelper.status: 1,
        };
        await dbHelper.insert(row);

        // Response response = await Dio().post(
        //   'http://192.168.42.175/SqliteSync/saveName.php',
        //   options: Options(headers: {
        //     HttpHeaders.contentTypeHeader: "application/json",
        //   }),
        //   data: jsonEncode(<String, dynamic>{"name": text.toString(), "status": a}),
        // );
        //
        // if (response.statusCode == 200) {
        //   String body = response.statusMessage;
        //   print(body);
        //   Map<String, dynamic> row = {
        //     DatabaseHelper.columnName: text.toString(),
        //     DatabaseHelper.status: 1,
        //   };
        //   await dbHelper.insert(row);
        // } else {
        //   print('Request failed with status: ${response.statusCode}.');
        // }
      } else {
        Map<String, dynamic> row = {
          DatabaseHelper.prodName: data.toString(),
          DatabaseHelper.status: 0,
        };
        final id = await dbHelper.insert(row);
        print('inserted row id: $id');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> sync(data, _connectionStatus) async {
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    print(data.toString());
    int a = 1;
    print(_connectionStatus.toString());
    try {
      if (_connectionStatus == true) {
        var headers = {'Authorization': 'Bearer $token'};
        APIManager _manager = APIManager();
        var response;

        response = await _manager.postAPICallWithHeader(ApiClient.login, data, headers);
        print('response: ${response}');

        String body = response.statusMessage;
        print(body);
      } else {}
    } catch (error) {
      throw (error);
    }
  }


  Future<PlaceDataModel> readLocationJsonData() async {
    //read json file
    final jsondata = await rootBundle.loadString('assets/place/users.json');
    //decode json data as list
    final list = json.decode(jsondata);

    print(list);

    return PlaceDataModel.fromJson(list);
  }


  Future<MedicineListResponse> get_drug_list() async {

    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //var headers = {'Authorization': 'Bearer '};
    APIManager _manager = APIManager();
    var response;
    try {
      response = await _manager.get(ApiClient.drug_list,headers);
      print('responsedruglist: ${response}');

      if(response == null){
       // Get.toNamed(Routes.LOGIN);
      }

      return MedicineListResponse.fromJson(response);
      // return all_division_dis_thanan_model().fromJson(response);
      //  if (response['IsLoggedIn'] == true) {
      //    Get.find<AuthService>().setUser(UserModel.fromJson(response));
      //    return all_division_dis_thanan_model.fromJson(response);
      //  } else {
      //    return 'Unauthorised';
      //  }
    } catch (e) {
      print('error:$e');
      Get.toNamed(Routes.LOGIN);
      return MedicineListResponse.fromJson(response);
    }
  }

  Future<StockReceiveResponse> get_stock_receive_list(String url) async {

    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //var headers = {'Authorization': 'Bearer '};
    APIManager _manager = APIManager();
    var response;
    try {
      response = await _manager.get(ApiClient.stock_receive_list+'/'+url,headers);
      print('responsedruglist: ${response}');

      if(response == null){
        // Get.toNamed(Routes.LOGIN);
      }

      return StockReceiveResponse.fromJson(response);
      // return all_division_dis_thanan_model().fromJson(response);
      //  if (response['IsLoggedIn'] == true) {
      //    Get.find<AuthService>().setUser(UserModel.fromJson(response));
      //    return all_division_dis_thanan_model.fromJson(response);
      //  } else {
      //    return 'Unauthorised';
      //  }
    } catch (e) {
      print('error:$e');
      Get.toNamed(Routes.LOGIN);
      return StockReceiveResponse.fromJson(response);
    }
  }

  Future<StockReceiveMedicineListResponse> get_stock_receive_medicine_list(String id) async {

    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //var headers = {'Authorization': 'Bearer '};
    APIManager _manager = APIManager();
    var response;
    try {
      response = await _manager.get(ApiClient.stock_receive_medicine_list+'/'+id,headers);
      print('responsedruglist: ${response}');

      if(response == null){
        // Get.toNamed(Routes.LOGIN);
      }

      return StockReceiveMedicineListResponse.fromJson(response);
      // return all_division_dis_thanan_model().fromJson(response);
      //  if (response['IsLoggedIn'] == true) {
      //    Get.find<AuthService>().setUser(UserModel.fromJson(response));
      //    return all_division_dis_thanan_model.fromJson(response);
      //  } else {
      //    return 'Unauthorised';
      //  }
    } catch (e) {
      print('error:$e');
      Get.toNamed(Routes.LOGIN);
      return StockReceiveMedicineListResponse.fromJson(response);
    }
  }


}
