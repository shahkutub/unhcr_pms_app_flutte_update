

import 'dart:convert';

import 'package:brac_arna/app/models/drug_list_response.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../common/ui.dart';
import '../../../api_providers/api_url.dart';
import '../../../database_helper/offline_database_helper.dart';
import '../../../models/MedicineListResponse.dart';
import '../../../models/StockReceiveMedicineListResponse.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../utils.dart';
import 'package:http/http.dart' as http;

import '../../login/controllers/after_login_controller.dart';

class InternalRequestController extends GetxController{
  final List<StockoutDetail> internal_receive_medicine_list = <StockoutDetail>[].obs;

  int internalRequestNumber = 0;


  static InternalRequestController get i => Get.find();
  var txt = TextEditingController().obs;
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'].obs;
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2].obs;

  final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<DispatchItem> drugList = <DispatchItem>[].obs;
  final List<InternalItemModel> internalReqList = <InternalItemModel>[].obs;
  final List<InternalItemModel> internalReqListDistinck = <InternalItemModel>[].obs;
  final drugData = DrugInfo().obs;

  var  requestQtyLabelText = '0'.obs;
  var requestEditQtyController = TextEditingController().obs;
  var remarkEditController = TextEditingController().obs;
  var controllerItemName = TextEditingController().obs;
  var selectedDate = DateTime.now().obs;
  var etSkillScore1Key = GlobalKey<FormState>().obs;
  var nameInput = ''.obs;
  var selected_spinner_item = 'Select Item'.obs;
  var itemName = ''.obs;
  var itemId = ''.obs;
  var batchId = ''.obs;
  var itemAvQty = '0'.obs;
  var itemQty = 0.obs;
  var remark = ''.obs;

  var userNAme = ''.obs;
  var userRole = ''.obs;
  var selectedItem = ''.obs;
  var pSerialN0 = '0'.obs;
  var itemSize = 0.obs;
  final dbHelper = DatabaseHelper.instance;
  //final druglistResonse = DrugListResponse().obs;
  final List<InternalItemModel> internalRequestSubmitList = <InternalItemModel>[];
  var dispensaryId = "";
  var facilityId = '';
  var partnerId = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    remarkEditController.value.text = "";

    remarkEditController.value.addListener(() {

      if(int.parse(remarkEditController.value.text.toString()) > int.parse(requestEditQtyController.value.text.toString())){
        Utils.showToast('Dispatch quantity must be less than available quantity!');
        remarkEditController.value.text = "";
      }
    });
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.employee_info!.facility_id.toString();

    print('facilityID: '+userNAme.value);

    //userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!;
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;
    dispensaryId = Get.find<AuthService>().currentUser.value.data!.employee_info!.dispensary_id!;
    facilityId = Get.find<AuthService>().currentUser.value.data!.employee_info!.facility_id!;
    partnerId = Get.find<AuthService>().currentUser.value.data!.employee_info!.partner_id!;

    //insert_patient_serialToLocalDB();

    //Utils.replaceEngMonthNameBangla();
    //Utils.currentDateBengali();


    // getPSerialNo();
     get_drug_list();
    get_internal_request_list();

    //submit_dispatch();

  }


  Future<void> getPSerialNo() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    await dbHelper.deleteSerial(formattedDate);

    var localdataSize = await dbHelper.getAllPatientSerial();
    itemSize.value = localdataSize.length;
    print('pserialSize: ${localdataSize.length}');
    pSerialN0.value = '${localdataSize.length + 1}';
  }

  // insert serial
  Future<void> insert_patient_serialToLocalDB() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    Map<String, dynamic> row = {
      DatabaseHelper.date: formattedDate
    };
    await dbHelper.insert_patient_serial(row);
    var localdataSize = await dbHelper.getAllPatientSerial();
    print('localdataSize: ${localdataSize.length}');
    getPSerialNo();
    get_drug_list();


    //await dbHelper.deleteSerial(formattedDate);

    //await dbHelper.insert_patient_serial(row);
    // var localdataSize2 = await dbHelper.getAllPatientSerial();
    // print('localdataSize: ${localdataSize2.length}');

    // var localdataSize = await dbHelper.queryAllRecords();
    // print('localdataSize: ${localdataSize.length}');
    // for (var i = 0; i < localdataSize.length; i++) {
    //   Map<String, dynamic> map = localdataSize[i];
    //   var name = map['name'];
    //   print("name: "+name);
    //   // var id = map['id'];
    // }


  }

  // insert item_dispatch
  Future<void> insert_internal_request(ItemDispatchModel data ,String serial) async {

    Map<String, dynamic> row = {
      DatabaseHelper.internal_req_serial: serial,
      DatabaseHelper.internal_req_date: data.date,
      DatabaseHelper.internal_req_med_name: data.medicine_name,
      DatabaseHelper.internal_req_med_id: data.medicine_id,
      DatabaseHelper.internal_req_qty: data.medicine_qty,
      DatabaseHelper.internal_req_remark: data.remark
    };
    await dbHelper.insert_internal_request(row);
    var localdataSize = await dbHelper.get_internal_request();
    print('internal_requestSize: ${localdataSize.length}');

    get_internal_request_list();
  }

  void updateDrugAvailableQty(int id,int qty ,int qtyConsume) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DatabaseHelper.instance.database;

    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.drug_available_stock  : qty.toString(),
      DatabaseHelper.drug_stock_consume  : qtyConsume.toString()
    };

    await db.update(
        DatabaseHelper.table_drugs,
        row,
        where: '${DatabaseHelper.drug_id} = ?',
        whereArgs: [id]);
    await db.query(DatabaseHelper.table);
    // show the results: print all rows in the db
    //print(await db.query(DatabaseHelper.table));
  }

  // void approveStockReceive(BuildContext context, String stockout_master_id){
  //   //dbHelper.deleteALlDrugs();
  //   internal_receive_medicine_list!.forEach((element2) async{
  //       Map<String, dynamic> row = {
  //         DatabaseHelper.drug_name: ''+element2.drug_name.toString(),
  //         DatabaseHelper.drug_id: element2.drug_id,
  //         //DatabaseHelper.drug_pstrength_name: ''+element.strength_name.toString(),
  //         //DatabaseHelper.drug_pstrength_id: element.pstrength_id,
  //         //DatabaseHelper.drug_generic_name: ''+element.generic_name.toString(),
  //         //DatabaseHelper.drug_generic_id: element.generic_id,
  //         DatabaseHelper.drug_available_stock: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
  //         DatabaseHelper.drug_stock_receive: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
  //         DatabaseHelper.drug_stock_consume: '0',
  //         DatabaseHelper.drug_stock_lose: element2.reject_qty!=null?element2.reject_qty:'',
  //         DatabaseHelper.drug_reject_reason: element2.reject_reason!=null?element2.reject_reason:'',
  //
  //         DatabaseHelper.drug_batch_no: element2.batch_no,
  //         DatabaseHelper.stockout_master_id: stockout_master_id,
  //         DatabaseHelper.drug_receive_type: '2',
  //         //DatabaseHelper.drug_stock: element.generic_id,
  //       };
  //
  //       await dbHelper.insert_drug(row);
  //     });
  //
  //
  //
  //   Utils.showToastWithTitle('','Stock received done');
  //   Navigator.pop(context);
  //   // var localdataSize =  dbHelper.queryAllDrugRows();
  //   // print('localdataDrugSize: ${localdataSize.length}');
  // }

  void approveStockReceive(BuildContext context, String stockout_master_id){
    print('stockout_master_id: ${stockout_master_id}');
    //dbHelper.deleteALlDrugs();
      internal_receive_medicine_list!.forEach((element2) async{
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

          DatabaseHelper.drug_batch_no: element2.batch_no,
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


    Utils.showToastWithTitle('','Stock received done');
    Navigator.pop(context);
    // var localdataSize =  dbHelper.queryAllDrugRows();
    // print('localdataDrugSize: ${localdataSize.length}');
  }


  void addItemToList(){
    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedDate = formatter.format(now);
    // print(formattedDate);
    //var item = ItemDispatchModel(pSerialN0.value,"",formattedDate,drugData.value.name.toString(),drugData.value.id!,drugData.value.generic_name.toString(),drugData.value.generic_name.toString(),itemQty.value);
    var item = ItemDispatchModel(txt.value.text,itemName.value.toString(),remark.value,int.parse(itemId.value.toString()),batchId.value,itemQty.value);
    itemList.insert(0, item);
    //print("itemList: "+itemList[0].name);

  }

  get_internal_request_list_by_serial(String serial) async {
    internal_receive_medicine_list.clear();
    var localdataSize2 = await dbHelper.get_internal_request();
    print('internal_requestSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var serialNo = map[DatabaseHelper.internal_req_serial];
      if(serialNo == serial){
        var madeid = map[DatabaseHelper.internal_req_med_id];
        var madename = map[DatabaseHelper.internal_req_med_name];
        var requestQty = map[DatabaseHelper.internal_req_qty];
        var remark = map[DatabaseHelper.internal_req_remark];
        var date = map[DatabaseHelper.internal_req_date];
        var drug_info = StockoutDetail(drug_name:madename ,drug_id: madeid.toString(),receive_qty:requestQty.toString());

        internal_receive_medicine_list.add(drug_info);
      }

    }
    print("inter_rec_medilist: "+internal_receive_medicine_list.length.toString());
  }

  get_internal_request_list() async {
    internalReqList.clear();
    internalReqListDistinck.clear();
    var localdataSize2 = await dbHelper.get_internal_request();
    print('internal_requestSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var madeid = map[DatabaseHelper.internal_req_med_id];
      var requestQty = map[DatabaseHelper.internal_req_qty];
      var remark = map[DatabaseHelper.internal_req_remark];
      var date = map[DatabaseHelper.internal_req_date];
      var serial = map[DatabaseHelper.internal_req_serial];
      var drug_info = InternalItemModel(madeid,requestQty,remark,date,serial);

      internalReqList.add(drug_info);
      internalReqListDistinck.add(drug_info);
    }

    final ids = Set();
    internalReqListDistinck.retainWhere((x) => ids.add(x.serial));
    internalRequestNumber = internalReqListDistinck.length +1;
    print("drugList: "+drugList.length.toString());
  }

  get_drug_list() async {
    drugList.clear();
    var localdataSize2 = await dbHelper.queryAllDrugRows();
    print('localdataDrugSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var drug_info = DispatchItem();
      drug_info.drug_name = map[DatabaseHelper.drug_name];
      drug_info.drug_id = map[DatabaseHelper.drug_id];
      drug_info.generic_id = map[DatabaseHelper.drug_generic_id];
      drug_info.generic_name = map[DatabaseHelper.drug_generic_name];
      drug_info.available_stock = map[DatabaseHelper.drug_available_stock];
      drug_info.dispatch_stock = map[DatabaseHelper.drug_stock_consume];
      //drug_info.pstrength_id = map[DatabaseHelper.drug_pstrength_id];
      drugList.add(drug_info);
    }
    print("drugList: "+drugList.length.toString());
  }



  internalRequestSubmitLocalOnline(BuildContext context, String serial) async {

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    if(await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'Internet connection found, internal request is submitting to online DB '));

      itemList.forEach((element) {

        var drug_info = InternalItemModel(element.medicine_id,
            element.medicine_qty,
            element.remark,
            formattedDate,
            serial);
        internalRequestSubmitList.add(drug_info);

      });

      print("internalRequestSubmitList: "+internalRequestSubmitList.length.toString());

      InternalRequestSubmitModel submitDispatchModel = InternalRequestSubmitModel( int.parse(dispensaryId ), int.parse(facilityId),int.parse(partnerId),formattedDate,internalRequestSubmitList,"online");
      String jsonData = jsonEncode(submitDispatchModel);
      print('internalRequestjson: '+jsonData.toString());

      postInternalRequest( jsonData,context);

    }else{
      itemList.forEach((element) async {
        insert_internal_request(element,serial);


       //stock insert/update
        String existDrugName = '';
        int availStock = 0;
        try{
          var data =  await dbHelper.querySingleDrug(element.medicine_id.toString(),element.batch_id.toString());
          Map<String, dynamic> map = data[0];
          availStock = int.parse(map[DatabaseHelper.drug_available_stock]);
          existDrugName = map[DatabaseHelper.drug_stock_receive];
          print('availStock: '+availStock.toString());
        }catch (e){

        }

        String? recqtyStr = element.medicine_qty!.toString();
        int receQuantity = int.parse(recqtyStr!);
        availStock = availStock+receQuantity;

        Map<String, dynamic> row = {
          DatabaseHelper.drug_name: ''+element.medicine_name.toString(),
          DatabaseHelper.drug_id: element.medicine_id.toString(),
          //DatabaseHelper.drug_pstrength_name: ''+element.strength_name.toString(),
          //DatabaseHelper.drug_pstrength_id: element.pstrength_id,
          //DatabaseHelper.drug_generic_name: ''+element.generic_name.toString(),
          //DatabaseHelper.drug_generic_id: element.generic_id,

          //DatabaseHelper.drug_available_stock: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
          DatabaseHelper.drug_available_stock: availStock.toString(),
          //DatabaseHelper.drug_stock_receive: element2.receive_qty!.isNotEmpty?element2.receive_qty:element2.supplied_qty!,
          DatabaseHelper.drug_stock_receive: availStock.toString(),
          DatabaseHelper.drug_stock_consume: '0',
          //DatabaseHelper.drug_stock_lose: element2.reject_qty!=null?element2.reject_qty:'0',
          //DatabaseHelper.drug_reject_reason: element2.reject_reason!=null?element2.reject_reason:'',

          DatabaseHelper.drug_batch_no: element.batch_id,
          DatabaseHelper.drug_receive_type: '2',
          //DatabaseHelper.stockout_master_id: stockout_master_id,
          //DatabaseHelper.drug_stock: element.generic_id,
        };


        if(existDrugName.isNotEmpty){
          await dbHelper.updateDrug(row);
        }else{
          await dbHelper.insert_drug(row);
        }



      });

      itemList.clear();

    }


  }


  Future<dynamic> postInternalRequest(String data,BuildContext context) async {

    Ui.showLoaderDialog(context);
    // String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //String? token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdW5oY3J0ZXN0YXBpLmxhMzYwaG9zdC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjY2Nzg2NzUsImV4cCI6MTY2NjY4MjI3NSwibmJmIjoxNjY2Njc4Njc1LCJqdGkiOiIyeWdlZ2h3eDN4em15SDVrIiwic3ViIjoxNiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.FVCE70a3yE23PwRnmANVMdBUKzexcSuhKfRhoSdlkWg';
    print("token: ${token}");

    var response = await http.post(Uri.parse(ApiClient.submit_internal_request),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );

    print("statusCode: ${response.statusCode}");
    if(response.statusCode == 500){
      //logout();
      Get.offAllNamed(Routes.LOGIN);
    }

    if(response.statusCode == 401){
      //logout();
      Get.offAllNamed(Routes.LOGIN);
    }

    print("${response.body}");

    var jsoObj = jsonDecode(response.body);

    var status = jsoObj['status'];
    print("status:${status}");
    if(status == 'success'){
      Get.back();
      Utils.showToast('Internal request upload successful');
     // dbHelper.delete_internal_request();
      //Get.offAllNamed(Routes.AFTER_LOGIN);
    }

    //Navigator.of(context).pop();

    return response;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


}

class ItemDispatchModel {

  var date = "";
  var medicine_name = "";
  var remark = "";
  var medicine_id = 0;
  var batch_id = '';

  var medicine_qty = 0;

  ItemDispatchModel(

      this.date,
      this.medicine_name,
      this.remark,
      this.medicine_id,
      this.batch_id,
      this.medicine_qty);
}
