

import 'package:brac_arna/app/models/drug_list_response.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../database_helper/offline_database_helper.dart';
import '../../../services/auth_service.dart';

class InternalRequestController extends GetxController{

  static InternalRequestController get i => Get.find();
  //final GlobalKey<FormFieldBuilder> key = GlobalKey<FormBuilderState>();

  // final List<String> _suggestions = <String>[
  //   'Alligator',
  //   'Buffalo',
  //   'Chicken',
  //   'Dog',
  //   'Eagle',
  //   'Frog'
  // ].obs;
  final List areaList = [
    {"name": "Block 1", "id": "124612615"},
    {"name": "Block 2", "id": "124612615"},
    {"name": "Block 3", "id": "124612615"},
    {"name": "PECHS block 1", "id": "124612615"},
    {"name": "PECHS block 2", "id": "124612615"},
    {"name": "PECHS block 3", "id": "124612615"},
    {"name": "PECHS block 4", "id": "124612615"},
    {"name": "PECHS block 5", "id": "124612615"},
    {"name": "PECHS block 6", "id": "124612615"},
    {"name": "PECHS block 7", "id": "12461265"},
    {"name": "PECHS block 8", "id": "12461215"},
    {"name": "PECHS block 9", "id": "12461615"},
    {"name": "PECHS block 0", "id": "12462615"},
    {"name": "PECHS block 89", "id": "12612615"},
    {"name": "PECHS block 88", "id": "1261265"},
    {"name": "PECHS block 87", "id": "14612615"},
  ];
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'].obs;
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2].obs;
  final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<ItemDispatchModel> searchItemList = <ItemDispatchModel>[].obs;
  final List<DrugInfo> drugList = <DrugInfo>[].obs;
  var controllerQty = TextEditingController().obs;
  var controllerItemName = TextEditingController().obs;


  var nameInput = ''.obs;
  var itemName = ''.obs;
  var itemAvQty = '0'.obs;
  var itemQty = ''.obs;

  var userNAme = ''.obs;
  var userRole = ''.obs;
  var selectedItem = ''.obs;
  var pSerialN0 = '0'.obs;
  final dbHelper = DatabaseHelper.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controllerQty.value.text = "0";
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;
    //insert_patient_serialToLocalDB();

     getPSerialNo();

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

  get_drug_list() async {
    var localdataSize2 = await dbHelper.queryAllDrugRows();
    print('localdataDrugSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var drug_info = DrugInfo();
      drug_info.name = map[DatabaseHelper.drug_name];
      drug_info.id = map[DatabaseHelper.drug_id];
      drug_info.generic_id = map[DatabaseHelper.drug_generic_id];
      drug_info.generic_name = map[DatabaseHelper.drug_generic_name];
      //drug_info.pstrength_name = map[DatabaseHelper.drug_pstrength_name];
      drug_info.pstrength_id = map[DatabaseHelper.drug_pstrength_id];
      drugList.add(drug_info);
    }
    print("drugList: "+drugList.length.toString());
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