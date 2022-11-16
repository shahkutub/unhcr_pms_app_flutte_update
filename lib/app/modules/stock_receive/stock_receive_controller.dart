

import 'package:brac_arna/app/database_helper/offline_database_helper.dart';
import 'package:brac_arna/app/models/StockReceiveResponse.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/ui.dart';
import '../../models/MedicineListResponse.dart';
import '../../models/drug_list_response.dart';
import '../../repositories/information_repository.dart';
import '../../routes/app_pages.dart';
import '../../utils.dart';



class StockReceiveController extends GetxController{

  static StockReceiveController get i => Get.find();

  var button = 1.obs;


  final dbHelper = DatabaseHelper.instance;

  final druglistResonse = MedicineListResponse().obs;
  final stockReceiveResponse = StockReceiveResponse().obs;
  var showCircle = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get_drug_listReceive();
    get_stock_Receive();
  }

  get_stock_Receive() async {
    //Get.focusScope!.unfocus();

    //Ui.customLoaderDialogWithMessage();
    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      showCircle.value = true;

      InformationRepository().get_stock_receive_list().then((resp) async {
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


  get_drug_listReceive() async {
    //Get.focusScope!.unfocus();

    //Ui.customLoaderDialogWithMessage();
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


  void approveStockReceive(BuildContext context){
    dbHelper.deleteALlDrugs();
    druglistResonse.value.dispatch_items!.forEach((element) async {
      Map<String, dynamic> row = {
        DatabaseHelper.drug_name: ''+element.drug_name.toString(),
        DatabaseHelper.drug_id: element.drug_id,
        DatabaseHelper.drug_pstrength_name: ''+element.strength_name.toString(),
        DatabaseHelper.drug_pstrength_id: element.pstrength_id,
        DatabaseHelper.drug_generic_name: ''+element.generic_name.toString(),
        DatabaseHelper.drug_generic_id: element.generic_id,
        DatabaseHelper.drug_available_stock: element.available_stock,
        DatabaseHelper.drug_stock_receive: element.available_stock,
        DatabaseHelper.drug_stock_consume: '0',
        DatabaseHelper.drug_stock_lose: '0',
        //DatabaseHelper.drug_stock: element.generic_id,
      };

      await dbHelper.insert_drug(row);
    });

    Utils.showToastWithTitle('','Stock received done');
    Navigator.pop(context);
    // var localdataSize =  dbHelper.queryAllDrugRows();
    // print('localdataDrugSize: ${localdataSize.length}');
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


        }else{

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