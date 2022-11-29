

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../database_helper/offline_database_helper.dart';
import '../../../services/auth_service.dart';

class ConsumptionTallyController extends GetxController{

  static ConsumptionTallyController get i => Get.find();


  final List<ItemDispatchModel> tallyitemList = <ItemDispatchModel>[].obs;
  final List<ItemDispatchModel> tallyitemListDateBased = <ItemDispatchModel>[].obs;
  List<ItemDispatchModel> tallyitemListDistincByMedName = <ItemDispatchModel>[].obs;

  var selectedDate = DateTime.now().obs;

  var txt = TextEditingController().obs;
  var seen = Set<String>();


  final List<ItemDispatchModel> searchItemList = <ItemDispatchModel>[].obs;

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

    // getPSerialNo();

    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    //tallyDate.value = formatter.format(now);
    print('tallyDate: '+formattedDate);

    txt.value.text = formatter.format(now);

    getItemDispatch(formatter.format(now).toString());

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




  }

  Future<void> getItemDispatch(String date) async {



    // Map<String, dynamic> row = {
    //
    //   DatabaseHelper.item_dispatch_serial: 01,
    //   DatabaseHelper.date: formattedDate,
    //   DatabaseHelper.item_dispatch_medicine_name: 'napa',
    //   DatabaseHelper.item_dispatch_medicine_id: 0111,
    //   DatabaseHelper.item_dispatch_quantity: 10
    // };
    // await dbHelper.insert_item_dispatch(row);
    // var localdataSize = await dbHelper.get_tem_dispatch();
    // print('localdataitemSize: ${localdataSize.length}');

    tallyitemList.clear();
    tallyitemListDateBased.clear();
    tallyitemListDistincByMedName.clear();

    var localdataSize = await dbHelper.get_tem_dispatch();
    print('localdataitemSize: ${localdataSize.length}');

    for (var i = 0; i < localdataSize.length; i++) {
      Map<String, dynamic> map = localdataSize[i];
      var item_dispatch_quantity = map[DatabaseHelper.item_dispatch_quantity];
      print("item_dispatch_qty: "+item_dispatch_quantity.toString());

      tallyitemList.add(ItemDispatchModel(map[DatabaseHelper.date],map[DatabaseHelper.item_dispatch_medicine_name],
          map[DatabaseHelper.item_dispatch_medicine_id],map[DatabaseHelper.item_dispatch_serial],item_dispatch_quantity));

    }

    print("tallyitemList lenth: "+tallyitemList.length.toString());
    print("date: "+date.toString());

    tallyitemList.forEach((element) {
      if(element.dispatch_date == date){
        tallyitemListDateBased.add(element);
        tallyitemListDistincByMedName.add(element);
      }
    });

    print('tallyitemListDateBased: '+tallyitemListDateBased.length.toString());


    List<ItemDispatchModel> uniquelist = tallyitemListDateBased.where((student) => seen.add(student.medicine_id.toString())).toList();
    print('uniquelist: '+uniquelist.length.toString());

    final ids = Set();
    tallyitemListDistincByMedName.retainWhere((x) => ids.add(x.medicine_id));
    print('tallyitemListDistincByMedName: '+tallyitemListDistincByMedName.length.toString());

    // tallyitemListDistincByMedName.addAll(uniquelist);
    //
    // print('distinclist: '+tallyitemListDistincByMedName.length.toString());

  }

}

class ItemDispatchModel {
  var dispatch_date = "";
  var medicine_name = "";
  var medicine_id = 0;
  var patient_serial = 0;
  var item_dispatch_quantity = 0 ;

  ItemDispatchModel(this.dispatch_date,this.medicine_name, this.medicine_id, this.patient_serial,this.item_dispatch_quantity);
}