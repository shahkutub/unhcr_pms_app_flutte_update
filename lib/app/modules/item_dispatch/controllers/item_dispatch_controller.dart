

import 'dart:convert';

import 'package:brac_arna/app/api_providers/api_manager.dart';
import 'package:brac_arna/app/api_providers/api_url.dart';
import 'package:brac_arna/app/modules/item_dispatch/DispatchSubmitRspopnse.dart';
import 'package:brac_arna/app/utils.dart';
import 'package:brac_arna/common/ui.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../../database_helper/offline_database_helper.dart';
import '../../../models/MedicineListResponse.dart';
import '../../../models/drug_list_response.dart';
import '../../../repositories/information_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

class ItemDispatchController extends GetxController{

  static ItemDispatchController get i => Get.find();

  var itemlist = [
    "Medicine 1",
    "Medicine 2",
    "Medicine 3",
    "Medicine 4",
    "Medicine 5",
    "Medicine 6",
    "Medicine 7",
    "Medicine 7",
    "Medicine 8",
    "Medicine 9",
    "Medicine 10"
  ];

  final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<DispatchItem> drugList = <DispatchItem>[].obs;
  final drugData = DrugInfo().obs;

  var  controllerAvailableQtyLabelText = '0'.obs;
  var controllerAvailableQty = TextEditingController().obs;
  var dispatchQtyController = TextEditingController().obs;
  var controllerItemName = TextEditingController().obs;

  var etSkillScore1Key = GlobalKey<FormState>().obs;
  var nameInput = ''.obs;
  var selected_spinner_item = 'Select Item'.obs;
  var itemName = ''.obs;
  var itemId = ''.obs;
  var itemAvQty = '0'.obs;
  var itemQty = 0.obs;

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
    dispatchQtyController.value.text = "0";

    dispatchQtyController.value.addListener(() {

      if(int.parse(dispatchQtyController.value.text.toString()) > int.parse(controllerAvailableQty.value.text.toString())){
        Utils.showToast('Dispatch quantity must be less than available quantity!');
        dispatchQtyController.value.text = "";
      }
    });
    // userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    // userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;
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
  Future<void> insert_item_dispatch_ToLocalDB(ItemDispatchModel data) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    Map<String, dynamic> row = {
      DatabaseHelper.date: data.date,
      DatabaseHelper.item_dispatch_serial: data.serial_no,
      DatabaseHelper.item_dispatch_medicine_name: data.medicine_name,
      DatabaseHelper.item_dispatch_medicine_id: data.medicine_id,
      DatabaseHelper.item_dispatch_quantity: data.medicine_qty
    };
    await dbHelper.insert_item_dispatch(row);
    var localdataSize = await dbHelper.get_tem_dispatch();
    print('localdataitemSize: ${localdataSize.length}');

    for (var i = 0; i < localdataSize.length; i++) {
      Map<String, dynamic> map = localdataSize[i];
      var item_dispatch_serial = map[DatabaseHelper.item_dispatch_serial];
      print("item_dispatch_serial: "+item_dispatch_serial.toString());
      // var id = map['id'];
    }


  }

  void updateDrugAvailableQty(int id,int qty) async {

    // get a reference to the database
    // because this is an expensive operation we use async and await
    Database db = await DatabaseHelper.instance.database;

    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.drug_available_stock  : qty
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
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    //var item = ItemDispatchModel(pSerialN0.value,"",formattedDate,drugData.value.name.toString(),drugData.value.id!,drugData.value.generic_name.toString(),drugData.value.generic_name.toString(),itemQty.value);
    var item = ItemDispatchModel(pSerialN0.value,"",formattedDate,itemName.value.toString(),int.parse(itemId.value.toString()),'','',itemQty.value);
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
      //drug_info.pstrength_id = map[DatabaseHelper.drug_pstrength_id];
      drugList.add(drug_info);
    }
    print("drugList: "+drugList.length.toString());
  }

  submit_dispatch(BuildContext context){
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
    postRequestDispatch(jsonTutorial,context);
    //return jsonTutorial;
  }

  Future<dynamic> postRequestDispatch (String data,BuildContext context) async {

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
  var serial_no = "";
  var patient_name = "";
  var date = "";
  var medicine_name = "";
  var medicine_id = 0;
  var medicine_generic_name = "";
  var medicine_generic_id = "";
  var medicine_qty = 0;
  var medicine_deduct_qty = 0;

  ItemDispatchModel(
      this.serial_no,
      this.patient_name,
      this.date,
      this.medicine_name,
      this.medicine_id,
      this.medicine_generic_name,
      this.medicine_generic_id,
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