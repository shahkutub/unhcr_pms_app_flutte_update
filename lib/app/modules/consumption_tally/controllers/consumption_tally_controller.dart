

import 'dart:convert';

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
  List<ItemDispatchModel> tallyListDistincByDate = <ItemDispatchModel>[].obs;
  List<ItemDispatchModel> tallyListDistincByPserial = <ItemDispatchModel>[].obs;

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



    tallyitemList.clear();
    tallyitemListDateBased.clear();
    tallyitemListDistincByMedName.clear();
    tallyListDistincByDate.clear();
    tallyListDistincByPserial.clear();

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
        tallyListDistincByDate.add(element);
        tallyListDistincByPserial.add(element);
      }
    });

    print('tallyitemListDateBased: '+tallyitemListDateBased.length.toString());


    List<ItemDispatchModel> uniquelist = tallyitemListDateBased.where((student) => seen.add(student.medicine_id.toString())).toList();
    print('uniquelist: '+uniquelist.length.toString());

    final ids = Set();
    tallyitemListDistincByMedName.retainWhere((x) => ids.add(x.medicine_id));
    tallyListDistincByDate.retainWhere((x) => ids.add(x.dispatch_date));
    tallyListDistincByPserial.retainWhere((x) => ids.add(x.patient_serial));
    print('tallyitemListDistincByMedName: '+tallyitemListDistincByMedName.length.toString());
    print('tallyListDistincByDate: '+tallyListDistincByDate.length.toString());
    print('tallyListDistincByPserial: '+tallyListDistincByPserial.length.toString());





    List<SubmitDispatchModel> medicinemain = [];
   // String datedata = '';
    //String pSerial = '';

    tallyListDistincByDate.forEach((elementDate) {
      String datedata = elementDate.dispatch_date;
      tallyListDistincByPserial.forEach((elementPs) {
        List<MedicineModel> medicineDetails = [];
        String pSerial = elementPs.patient_serial.toString();
        print('datedata: '+datedata);
        print('pSerial: '+pSerial);
        tallyitemList.forEach((elementItem) {

          if(
          elementDate.dispatch_date == elementItem.dispatch_date &&
              elementPs.patient_serial == elementItem.patient_serial){

            print('mediname: '+elementItem.medicine_name);
            MedicineModel medicineModel = MedicineModel(int.parse(elementItem.medicine_id.toString()),int.parse(elementItem.item_dispatch_quantity.toString()));
            medicineDetails.add(medicineModel);
          }
        });
        SubmitDispatchModel submitDispatchModel = SubmitDispatchModel( datedata,pSerial, medicineDetails);
        medicinemain.add(submitDispatchModel);
      });

    });



    //String jsonTutorial = jsonEncode(submitDispatchModel);
    String jsonTutorial = jsonEncode(medicinemain);
    print('postjson: '+jsonTutorial.toString());

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




class SubmitDispatchModel{

  var dispatch_date = "";
  var patient_serial = "";
  //var medicineDetails = "";
  List<MedicineModel> medicineDetails = [];

  SubmitDispatchModel(
      this.dispatch_date,this.patient_serial, this.medicineDetails);

  Map toJson() => {

    'dispatch_date': dispatch_date,
    'patient_serial': patient_serial,
    'dispatchDetails': medicineDetails,

  };

}

class MedicineModel{
  var item_id = 0;
  // var batch_id = 0;
  var dispatch_qty = 0;
  // var receive_stock = 0;
  //MedicineModel(this.item_id,this.batch_id, this.dispatch_qty,this.receive_stock);
  MedicineModel(this.item_id, this.dispatch_qty);
  Map toJson() => {
    'item_id': item_id,
    //'batch_id': batch_id,
    'dispatch_qty': dispatch_qty,
  };

}