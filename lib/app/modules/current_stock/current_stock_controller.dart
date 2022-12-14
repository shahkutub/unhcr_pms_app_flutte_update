

import 'package:brac_arna/app/database_helper/offline_database_helper.dart';
import 'package:brac_arna/app/services/auth_service.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/MedicineListResponse.dart';
import '../../models/drug_list_response.dart';



class CurrentStockController extends GetxController{

  static CurrentStockController get i => Get.find();


  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'].obs;
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2].obs;
  final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<ItemDispatchModel> searchItemList = <ItemDispatchModel>[].obs;

  var controllerQty = TextEditingController().obs;
  var controllerItemName = TextEditingController().obs;

  final List<DispatchItem> drugList = <DispatchItem>[].obs;
  final List<DispatchItem> openingStockList = <DispatchItem>[].obs;
  var pageName = ''.obs;
  var nameInput = ''.obs;
  var itemName = ''.obs;
  var itemAvQty = '0'.obs;
  var itemQty = ''.obs;

  var userNAme = ''.obs;
  var userRole = ''.obs;
  var selectedItem = ''.obs;
  var pSerialN0 = '0'.obs;
  final dbHelper = DatabaseHelper.instance;
  var isStockSubmitted = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    Get.find<AuthService>().setIsCurrentStockSubmitted(false);
    isStockSubmitted.value = Get.find<AuthService>().isStockSubmitted.value;

    print('IsCurrentStockSubmitted: '+isStockSubmitted.value.toString());

    pageName.value = AppConstant.pageName;
    controllerQty.value.text = "0";
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;
    //insert_patient_serialToLocalDB();

    //getPSerialNo();
    if(AppConstant.pageName == "Opening Stock"){
      get_opening_stock_list();
    }

    if(AppConstant.pageName == "Closing Stock"){
      get_drug_list();
    }

    if(AppConstant.pageName == "Current Stock"){
      get_drug_list();
    }



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
      drug_info.receive_stock = map[DatabaseHelper.drug_stock_receive];
      drug_info.lose_stock = map[DatabaseHelper.drug_stock_lose];
      drug_info.dispatch_stock = map[DatabaseHelper.drug_stock_consume];
      //drug_info.pstrength_id = map[DatabaseHelper.drug_pstrength_id];
      drugList.add(drug_info);
    }
    print("drugList: "+drugList.length.toString());
  }
  get_opening_stock_list() async {
    drugList.clear();
    var localDataOpeningStock = await dbHelper.queryAllOpeningStock();
    print('localDataOpeningStock: ${localDataOpeningStock.length}');
    for (var i = 0; i < localDataOpeningStock.length; i++) {
      Map<String, dynamic> map = localDataOpeningStock[i];
      var drug_info = DispatchItem();
      drug_info.drug_name = map[DatabaseHelper.drug_name];
      drug_info.drug_id = map[DatabaseHelper.drug_id];
      // drug_info.generic_id = map[DatabaseHelper.drug_generic_id];
      // drug_info.generic_name = map[DatabaseHelper.drug_generic_name];
      drug_info.available_stock = map[DatabaseHelper.drug_available_stock];
      // drug_info.receive_stock = map[DatabaseHelper.drug_stock_receive];
      // drug_info.lose_stock = map[DatabaseHelper.drug_stock_lose];
      // drug_info.dispatch_stock = map[DatabaseHelper.drug_stock_consume];
      //drug_info.pstrength_id = map[DatabaseHelper.drug_pstrength_id];
      drugList.add(drug_info);
    }
    print("openingStockList: "+drugList.length.toString());
  }


  Future<void> getPSerialNo() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    await dbHelper.deleteSerial(formattedDate);

    var localdataSize = await dbHelper.getAllPatientSerial();
    print('localdataSize: ${localdataSize.length}');
    pSerialN0.value = '${localdataSize.length + 1}';
  }

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

  void addItemToList(){

    var item = ItemDispatchModel(itemName.value, itemAvQty.value, itemQty.value);
    itemList.insert(0, item);
    print("itemList: "+itemList[0].name);

    names.insert(0,nameInput.value);
    msgCount.insert(0, 0);
    //itemAvQty.value = "";
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  onSearchTextChanged(String text) async {
    searchItemList.clear();
    if (text.isEmpty) {
      // setState(() {});
      return;
    }

    searchItemList.forEach((appointmentData) {
      if (appointmentData.name!.toLowerCase().contains(text.toLowerCase()))
        searchItemList.add(appointmentData);
    });


  }

}

class ItemDispatchModel {
  var name = "";
  var availqty = "";
  var qty = "";

  ItemDispatchModel(this.name, this.availqty, this.qty);
}