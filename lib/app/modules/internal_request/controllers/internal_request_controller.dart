

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
import '../../../services/auth_service.dart';
import '../../../utils.dart';
import 'package:http/http.dart' as http;

class InternalRequestController extends GetxController{

  static InternalRequestController get i => Get.find();
  var txt = TextEditingController().obs;
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'].obs;
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2].obs;

  final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<DispatchItem> drugList = <DispatchItem>[].obs;
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

    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!;
    //insert_patient_serialToLocalDB();

    //Utils.replaceEngMonthNameBangla();
    //Utils.currentDateBengali();


    getPSerialNo();
    get_drug_list();
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
  Future<void> insert_internal_request(ItemDispatchModel data) async {

    Map<String, dynamic> row = {
      DatabaseHelper.internal_req_date: data.date,
      DatabaseHelper.internal_req_med_name: data.medicine_name,
      DatabaseHelper.internal_req_med_id: data.medicine_id,
      DatabaseHelper.internal_req_qty: data.medicine_qty,
      DatabaseHelper.internal_req_remark: data.remark
    };
    await dbHelper.insert_internal_request(row);
    var localdataSize = await dbHelper.get_internal_request();
    print('internal_requestSize: ${localdataSize.length}');


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

  void addItemToList(){
    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd-MM-yyyy');
    // String formattedDate = formatter.format(now);
    // print(formattedDate);
    //var item = ItemDispatchModel(pSerialN0.value,"",formattedDate,drugData.value.name.toString(),drugData.value.id!,drugData.value.generic_name.toString(),drugData.value.generic_name.toString(),itemQty.value);
    var item = ItemDispatchModel(txt.value.text,itemName.value.toString(),remark.value,int.parse(itemId.value.toString()),itemQty.value);
    itemList.insert(0, item);
    //print("itemList: "+itemList[0].name);

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

  submit_internal_request(BuildContext context){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);


    List<MedicineModel> medicineDetails = [];

    itemList.forEach((element) {
      MedicineModel medicineModel = MedicineModel(element.medicine_id,element.medicine_qty);
      medicineDetails.add(medicineModel);
    });

    //MedicineModel medicineModel = MedicineModel(1,15);
    //List<MedicineModel> medicineDetails = [MedicineModel(1,15),MedicineModel(1,15),MedicineModel(1,15)];
    String jsonTags = jsonEncode(medicineDetails);
    print(jsonTags);

    //SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("1", "1", "1", "2022-05-06", medicineDetails);
    SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("1", "1", "1", formattedDate, jsonTags);
    String jsonTutorial = jsonEncode(submitDispatchModel);
    print(jsonTutorial.toString());
    postRequestInternalRequest(jsonTutorial,context);
    //return jsonTutorial;
  }

  Future<dynamic> postRequestInternalRequest (String data,BuildContext context) async {

    Ui.showLoaderDialog(context);
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;

    var response = await http.post(Uri.parse(ApiClient.submit_dispatch),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );
    print("${response.statusCode}");
    print("${response.body}");

    Navigator.of(context).pop();

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

  var medicine_qty = 0;

  ItemDispatchModel(

      this.date,
      this.medicine_name,
      this.remark,
      this.medicine_id,
      this.medicine_qty);
}

class Country {

  const Country({
    required this.name,
    required this.size,
  });

  final String name;
  final int size;

  @override
  String toString() {
    return '$name ($size)';
  }
}

class SubmitDispatchModel{
  var partner_id = "";
  var facility_id = "";
  var dispensary_id = "";
  var dispatch_date = "";
  var medicineDetails = "";
  //List<MedicineModel> medicineDetails = [];

  SubmitDispatchModel(this.partner_id, this.facility_id, this.dispensary_id,
      this.dispatch_date, this.medicineDetails);

  Map toJson() => {
    'partner_id': partner_id,
    'facility_id': facility_id,
    'dispensary_id': dispensary_id,
    'dispatch_date': dispatch_date,
    'medicineDetails': medicineDetails,

  };

}

class MedicineModel{
  var id = 0;
  var dispatch_qty = 0;
  MedicineModel(this.id, this.dispatch_qty);
  Map toJson() => {
    'id': id,
    'dispatch_qty': dispatch_qty,
  };
}

class User {
  String name;
  int age;
  User(this.name, this.age);
  Map toJson() => {
    'name': name,
    'age': age,
  };
}