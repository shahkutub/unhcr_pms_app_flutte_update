

import 'dart:convert';

import 'package:brac_arna/app/api_providers/api_url.dart';
import 'package:brac_arna/common/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/ElementData.dart';
import '../../../database_helper/offline_database_helper.dart';

import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

class AllDispatchController extends GetxController{

  static AllDispatchController get i => Get.find();

  //var  dispatchList = <ItemDispatchModel>[].obs;

  List<ItemDispatchModel> dispatchList = <ItemDispatchModel>[].obs;
  //List<ItemDispatchModel> dispatchList = [];
  final dbHelper = DatabaseHelper.instance;
  //final druglistResonse = DrugListResponse().obs;


  List<ElementData> elements = <ElementData>[
    ElementData(DateTime(2020, 6, 24, 18), 'Got to gym', Icons.fitness_center),
    ElementData(DateTime(2020, 6, 24, 9), 'Work', Icons.work),
    ElementData(DateTime(2020, 6, 25, 8), 'Buy groceries', Icons.shopping_basket),
    ElementData(DateTime(2020, 6, 25, 16), 'Cinema', Icons.movie),
    ElementData(DateTime(2020, 6, 25, 20), 'Eat', Icons.fastfood),
    ElementData(DateTime(2020, 6, 26, 12), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 27, 12), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 27, 13), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 27, 14), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 27, 15), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 28, 12), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 29, 12), 'Car wash', Icons.local_car_wash),
    ElementData(DateTime(2020, 6, 30, 12), 'Car wash', Icons.local_car_wash),
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    get_dispatch_list_local_db();

  }


  get_dispatch_list_local_db() async {
    var localdataSize2 = await dbHelper.queryAllDispatchRows();
    print('localdataDrugSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var drug_info = ItemDispatchModel();
      drug_info.serial_no = map[DatabaseHelper.item_dispatch_serial];
      drug_info.date = map[DatabaseHelper.date];
      drug_info.medicine_name = map[DatabaseHelper.item_dispatch_medicine_name];
      drug_info.medicine_id = map[DatabaseHelper.item_dispatch_medicine_id];
      drug_info.medicine_qty = map[DatabaseHelper.item_dispatch_quantity];

      dispatchList.add(drug_info);
    }
    print("dispatchList: "+dispatchList.length.toString());
  }

  submit_dispatch(BuildContext context){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);




    // List<SubmitDispatchModel> medicineDetails = [];
    //
    // dispatchList.forEach((element) {
    //   SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("16", "16", "1", formattedDate, jsonTags);
    //   medicineDetails.add(submitDispatchModel);
    // });

    //MedicineModel medicineModel = MedicineModel(1,15);
    //List<MedicineModel> medicineDetails = [MedicineModel(1,15),MedicineModel(1,15),MedicineModel(1,15)];
   // String jsonTags = jsonEncode(medicineDetails);
    String jsonTags = jsonEncode(dispatchList);
    print(jsonTags);

    // //SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("1", "1", "1", "2022-05-06", medicineDetails);
    // SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("1", "1", "1", formattedDate, jsonTags);
    // String jsonTutorial = jsonEncode(submitDispatchModel);
    // print(jsonTutorial.toString());
    // postRequestDispatch(jsonTutorial,context);
    //return jsonTutorial;
  }

  Future<dynamic> postRequestDispatch (BuildContext context) async {


    var items = ['1','2','3'];
    print(json.encode(items));
    print('jsonTags: '+json.encode(dispatchList).toString());
    String jsonTags = json.encode(dispatchList);


    Ui.showLoaderDialog(context);
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;

    var response = await http.post(Uri.parse(ApiClient.submit_dispatch),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: jsonTags
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
  int? serial_no;
  String? patient_name;
  String? date;
  String? medicine_name;
  int? medicine_id;
  String? medicine_generic_name;
  String? medicine_generic_id;
  int? medicine_qty;

  ItemDispatchModel({this.serial_no,
    this.patient_name,
    this.date,
    this.medicine_name,
    this.medicine_id,
    this.medicine_generic_name,
    this.medicine_generic_id,
    this.medicine_qty});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serial_no'] = this.serial_no;
    //data['patient_name'] = this.patient_name;
    data['date'] = this.date;
    data['medicine_name'] = this.medicine_name;
    data['medicine_id'] = this.medicine_id;
    //data['medicine_generic_name'] = this.medicine_generic_name;
    //data['medicine_generic_id'] = this.medicine_generic_id;
    data['medicine_qty'] = this.medicine_qty;

    return data;
  }
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

