

import 'package:brac_arna/app/database_helper/offline_database_helper.dart';
import 'package:brac_arna/app/models/StockReceiveMedicineListResponse.dart';
import 'package:brac_arna/app/models/StockReceiveResponse.dart';
import 'package:brac_arna/app/modules/stock_receive/StockReceiveDetailsResponse.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/ui.dart';
import '../../api_providers/api_url.dart';
import '../../models/MedicineListResponse.dart';
import '../../models/drug_list_response.dart';
import '../../repositories/information_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils.dart';
import 'dart:convert';
import 'dart:io';

import 'package:brac_arna/app/api_providers/customExceptions.dart';
import 'package:http/http.dart' as http;

import '../login/controllers/after_login_controller.dart';


class StockReceiveController extends GetxController{
  var isPending = true.obs;
  var isReceive = false.obs;
  static StockReceiveController get i => Get.find();

  var button = 1.obs;


  final dbHelper = DatabaseHelper.instance;

  final druglistResonse = MedicineListResponse().obs;
  var stockReceiveResponse = StockReceiveResponse().obs;
  final stockReceiveMedicineResponse = StockReceiveMedicineListResponse().obs;
  final stockReceiveDetailsResponse = StockReceiveDetailsResponse().obs;
  var showCircle = false.obs;
  final List<MediReceiveDetailsModel> stockReceiveSubmitList = <MediReceiveDetailsModel>[];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get_drug_listReceive();
    //get_stock_Receive('distribution_approved');
    getStockPending();
  }

  getStockPending() async {
    //print("Calling API: $url");

    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.back();
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
      var headers = {'Authorization': 'Bearer $token'};
      var responseJson;
      try {
        final response = await http.get(Uri.parse(ApiClient.stock_receive_list),headers: headers);
        print('statuscode: '+response.statusCode.toString());
        print('response: '+response.body.toString());
        if(response.statusCode == 500){
          Get.showSnackbar(Ui.defaultSnackBar(message: 'Authentication field'));
          Get.toNamed(Routes.LOGIN);
        }
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body.toString());

          //  List<dynamic> distribution_list = jsonResponse['distribution_list'];
          // if(distribution_list.length == 0){
          //   Get.back();
          //   Get.showSnackbar(Ui.defaultSnackBar(message: 'No data found'));
          // }

          stockReceiveResponse.value = StockReceiveResponse.fromJson(jsonResponse);
          if(stockReceiveResponse.value.distribution_list!.length == 0){
            //Get.back();
            Get.showSnackbar(Ui.defaultSnackBar(message: 'No data found'));
          }

          //return new StockReceiveResponse.fromJson(jsonResponse);
        } else {
          throw Exception('Failed to load data!');
        }
        //responseJson = _response(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    }

  }
  getStockReceived() async {
    //print("Calling API: $url");

    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.back();
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
      var headers = {'Authorization': 'Bearer $token'};
      var responseJson;
      try {
        final response = await http.get(Uri.parse(ApiClient.dispensary_received),headers: headers);
        print('statuscode: '+response.statusCode.toString());
        print('response: '+response.body.toString());
        if(response.statusCode == 500){
          Get.showSnackbar(Ui.defaultSnackBar(message: 'Authentication field'));
          Get.toNamed(Routes.LOGIN);
        }
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body.toString());

          //  List<dynamic> distribution_list = jsonResponse['distribution_list'];
          // if(distribution_list.length == 0){
          //   Get.back();
          //   Get.showSnackbar(Ui.defaultSnackBar(message: 'No data found'));
          // }

          stockReceiveResponse.value = StockReceiveResponse.fromJson(jsonResponse);
          if(stockReceiveResponse.value.distribution_list!.length == 0){
            Get.back();
            Get.showSnackbar(Ui.defaultSnackBar(message: 'No data found'));
          }

          //return new StockReceiveResponse.fromJson(jsonResponse);
        } else {
          throw Exception('Failed to load data!');
        }
        //responseJson = _response(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    }

  }

  get_stock_Receive(String pendingORreceive) async {
    //Get.focusScope!.unfocus();

    //Ui.customLoaderDialogWithMessage();
    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{


      InformationRepository().get_stock_receive_list(pendingORreceive).then((resp) async {
        stockReceiveResponse.value = resp;
        if(stockReceiveResponse.value != null){
          showCircle.value = false;
          print(druglistResonse.value.dispatch_items);

          showCircle.value = false;
        }else{
          Get.toNamed(Routes.LOGIN);
        }
      });
    }

  }
  get_stock_Receive_medicine(String id,BuildContext context) async {
    //Get.focusScope!.unfocus();

    //Ui.customLoaderDialogWithMessage();
    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      showCircle.value = true;

      InformationRepository().get_stock_receive_medicine_list(id).then((resp) async {
        stockReceiveMedicineResponse.value = resp;
       // Navigator.pop(context);
        if(stockReceiveMedicineResponse.value != null){
          showCircle.value = false;

          showCircle.value = false;
        }else{
          Get.toNamed(Routes.LOGIN);
        }
      });
    }

  }

  get_stock_Receive_medicine_view(String id,BuildContext context) async {
    //Get.focusScope!.unfocus();

    //Ui.customLoaderDialogWithMessage();
    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      showCircle.value = true;

      InformationRepository().get_stock_receive_medicine_list_view(id).then((resp) async {
        stockReceiveDetailsResponse.value = resp;
        // Navigator.pop(context);
        if(stockReceiveDetailsResponse.value != null){
          showCircle.value = false;

          showCircle.value = false;
        }else{
          Get.toNamed(Routes.LOGIN);
        }
      });
    }

  }

  get_drug_listReceive() async {
    //Get.focusScope!.unfocus();

    Ui.customLoaderDialogWithMessage();
    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      showCircle.value = true;

      InformationRepository().get_drug_list().then((resp) async {
        druglistResonse.value = resp;
        if(druglistResonse.value != null){
          showCircle.value = false;
          print(druglistResonse.value.dispatch_items);
          // Get.toNamed(Routes.LOGIN);
          // await dbHelper.deleteALlDrugs();
          // druglistResonse.value.dispatch_items!.forEach((element) async {
          //   Map<String, dynamic> row = {
          //     DatabaseHelper.drug_name: ''+element.drug_name.toString(),
          //     DatabaseHelper.drug_id: element.drug_id,
          //     DatabaseHelper.drug_pstrength_name: ''+element.strength_name.toString(),
          //     DatabaseHelper.drug_pstrength_id: element.pstrength_id,
          //     DatabaseHelper.drug_generic_name: ''+element.generic_name.toString(),
          //     DatabaseHelper.drug_generic_id: element.generic_id,
          //     DatabaseHelper.drug_available_stock: element.available_stock,
          //     DatabaseHelper.drug_stock_receive: element.available_stock,
          //     DatabaseHelper.drug_stock_consume: '0',
          //     DatabaseHelper.drug_stock_lose: '0',
          //     //DatabaseHelper.drug_stock: element.generic_id,
          //   };
          //
          //   await dbHelper.insert_drug(row);
          // });
          //
          // var localdataSize = await dbHelper.queryAllDrugRows();
          // print('localdataDrugSize: ${localdataSize.length}');

          showCircle.value = false;

          //Navigator.of(context).pop();
        }else{
          //Navigator.of(context).pop();
          Get.toNamed(Routes.LOGIN);
        }
      });
    }

  }

  get_stock_receive_submitdata(BuildContext context,String stockout_master_id) async {


    stockReceiveMedicineResponse.value.medicine_list!.forEach((element) async {
      element.stockout_details!.forEach((element2) async{
        var drug_info = MediReceiveDetailsModel(
          element2.drug_id!,
          element2.receive_qty!,
          element2.reject_qty.toString().isEmpty?'0':element2.reject_qty.toString(),
         element2.reject_reason.toString().isEmpty?'no':element2.reject_reason.toString(),
        );
        stockReceiveSubmitList.add(drug_info);
      });
    });

    print("stockReceiveSubmitList: "+stockReceiveSubmitList.length.toString());

    // var stockout_master_id = stockReceiveMedicineResponse.value.medicine_list![0].
    // stockout_details![0].facility_stockout_id;
    // print('stockout_master_id: ${stockout_master_id}');

    StockReceiveSubmitModel submitDispatchModel = StockReceiveSubmitModel( stockout_master_id!, stockReceiveSubmitList);
    String jsonData = jsonEncode(submitDispatchModel);
    print('stockreceivejson: '+jsonData.toString());

    if(stockReceiveSubmitList.length>0){
      submit_stock_receive( jsonData,context);
    }


  }

  Future<dynamic> submit_stock_receive(String data,BuildContext context) async {

    Ui.showLoaderDialog(context);
    // String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //String? token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdW5oY3J0ZXN0YXBpLmxhMzYwaG9zdC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjY2Nzg2NzUsImV4cCI6MTY2NjY4MjI3NSwibmJmIjoxNjY2Njc4Njc1LCJqdGkiOiIyeWdlZ2h3eDN4em15SDVrIiwic3ViIjoxNiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.FVCE70a3yE23PwRnmANVMdBUKzexcSuhKfRhoSdlkWg';
    print("token: ${token}");

    var response = await http.post(Uri.parse(ApiClient.submit_stock_receive),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );

    print("statusCode: ${response.statusCode}");
    if(response.statusCode == 500){
      Utils.showToastAlert('Server error');
      //logout();
      Get.offAllNamed(Routes.LOGIN);
    }

    print("${response.body}");

    var jsoObj = jsonDecode(response.body);

    var status = jsoObj['status'];
    print("status:${status}");
    if(status == 'success'){
      Utils.showToast('Stock receive upload successful');
      dbHelper.delete_internal_request();

    }

    Navigator.of(context).pop();

    return response;
  }


  void approveStockReceive(BuildContext context, String stockout_master_id){
    print('stockout_master_id: ${stockout_master_id}');
    //dbHelper.deleteALlDrugs();
    stockReceiveMedicineResponse.value.medicine_list!.forEach((element) async {
      element.stockout_details!.forEach((element2) async{
        //var data;
        String existDrugName = '';
        int availStock = 0;
        try{
          var data =  await dbHelper.querySingleDrug(element2.drug_id.toString(),element2.batch_no.toString());
          Map<String, dynamic> map = data[0];
          availStock = int.parse(map[DatabaseHelper.drug_available_stock]);
          existDrugName = map[DatabaseHelper.drug_stock_receive];
          print('availStock: '+availStock.toString());
        }catch (e){

        }

        String? recqtyStr = element2.receive_qty!.toString().isNotEmpty?element2.receive_qty:element2.supplied_qty!;
        int receQuantity = int.parse(recqtyStr!);
        availStock = availStock+receQuantity;

        Map<String, dynamic> row = {
          DatabaseHelper.drug_name: ''+element2.drug_name.toString(),
          DatabaseHelper.drug_id: element2.drug_id,
          DatabaseHelper.drug_batch_no: element2.batch_no,
          //DatabaseHelper.drug_batch_no: element2.batch_no,
          //DatabaseHelper.drug_pstrength_name: ''+element.strength_name.toString(),
          //DatabaseHelper.drug_pstrength_id: element.pstrength_id,
          //DatabaseHelper.drug_generic_name: ''+element.generic_name.toString(),
          //DatabaseHelper.drug_generic_id: element.generic_id,

          //DatabaseHelper.drug_available_stock: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
          DatabaseHelper.drug_available_stock: availStock,
          //DatabaseHelper.drug_stock_receive: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
          DatabaseHelper.drug_stock_receive: availStock,
          DatabaseHelper.drug_stock_consume: '0',
          DatabaseHelper.drug_stock_lose: element2.reject_qty!=null?element2.reject_qty:'0',
          DatabaseHelper.drug_reject_reason: element2.reject_reason!=null?element2.reject_reason:'',


          DatabaseHelper.drug_receive_type: '1',
          DatabaseHelper.stockout_master_id: stockout_master_id,
          //DatabaseHelper.drug_stock: element.generic_id,
        };


        if(existDrugName.isNotEmpty){
          await dbHelper.updateDrug(row);
        }else{
          await dbHelper.insert_drug(row);
        }

      });

    });

    Utils.showToastWithTitle('','Stock received done');
    Navigator.pop(context);
    // var localdataSize =  dbHelper.queryAllDrugRows();
    // print('localdataDrugSize: ${localdataSize.length}');
    get_stock_receive_submitdata( context, stockout_master_id);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Widget CustomRadioButton(String text, int index,BuildContext  context) {
    return TextButton(
      // return FlatButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(top: 15,bottom: 15),
      ),
      //color: (button.value == index) ? Colors.black : Colors.white,
      // color: (button.value == index) ? Colors.black : Colors.white,
      onPressed: () {
        button.value = index;
        if(button.value == 1){
          isPending.value = true;
          isReceive.value = false;
          if(stockReceiveResponse.value.distribution_list != null){
            stockReceiveResponse.value.distribution_list!.clear();
          }
          getStockPending();

        }else{
          isPending.value = false;
          isReceive.value = true;
          if(stockReceiveResponse.value.distribution_list != null){
            stockReceiveResponse.value.distribution_list!.clear();
          }
          getStockReceived();
        }
      },
      // child: Expanded(
      child:Container(
        padding: EdgeInsets.only(top: 7,bottom: 7),
        width: Get.width/3,

        child:Center(child: Text(
          text,
          style: TextStyle(
            color: (button.value == index) ? Colors.white : Colors.blue,
          ),
        ),),
        decoration: BoxDecoration(
          color: (button.value == index) ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      //),

      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //borderSide: BorderSide(color: (button.value == index) ? Colors.green : Colors.black),

    );
  }


}

class ItemDispatchModel {
  var name = "";
  var availqty = "";
  var qty = "";

  ItemDispatchModel(this.name, this.availqty, this.qty);
}