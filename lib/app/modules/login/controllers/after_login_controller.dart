import 'dart:async';
import 'dart:convert';

import 'package:brac_arna/app/database_helper/offline_database_helper.dart';
import 'package:brac_arna/app/models/drug_list_response.dart';
import 'package:brac_arna/app/models/user_model.dart';
import 'package:brac_arna/app/repositories/auth_repository.dart';
import 'package:brac_arna/app/repositories/information_repository.dart';
import 'package:brac_arna/app/routes/app_pages.dart';
import 'package:brac_arna/app/utils.dart';
import 'package:brac_arna/common/ui.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api_providers/api_url.dart';
import '../../../models/MedicineListResponse.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../consumption_tally/controllers/consumption_tally_controller.dart';

class after_login_controller extends GetxController {
  //TODO: Implement LoginController

  final Rx<UserModel> userData = UserModel().obs;
  Rx<TextEditingController> userNameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  final loading = false.obs;
  var latitude = 'Getting Latitude..'.obs;
  var longitude = 'Getting Longitude..'.obs;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription;
  late GlobalKey<FormState> loginFormKey;

  var isLocationEnable = false.obs;
  var isLocationPermission = false.obs;

  var userNAme = ''.obs;
  var userRole = ''.obs;
  var showCircle = false.obs;
  final dbHelper = DatabaseHelper.instance;
  final druglistResonse = MedicineListResponse().obs;

  final navigatorKey = GlobalKey<NavigatorState>();
  final List<DispatchItem> dispatchDrugList = <DispatchItem>[];
  //final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;

  @override
  void onInit() {
    print('after login home vie');
    // get_drug_listFirst();
    // get_drug_listFromLocalDb();
    navigatorKey: navigatorKey;
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;

    //get_drug_list();
    //getLocationPermission();
    //AuthRepository().allProd();


    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }



  void login() async {
    // userData.value.fullName = userNameController.value.text;
    // userData.value.password = passwordController.value.text;
    Get.focusScope!.unfocus();

    Ui.customLoaderDialogWithMessage();
    AuthRepository().userLogin(userData.value).then((response) {
      print(response);

      if(response != null){
        //String? loginData = Get.find<AuthService>().currentUser.value.api_info!.original!.access_token;
        Get.offAllNamed(Routes.AFTER_LOGIN);
        //Get.offAllNamed(Routes.HOME);
        // Get.find<RootController>().changePageOutRoot(0);
        Get.showSnackbar(Ui.SuccessSnackBar(message: 'Successfully logged in'.tr, title: 'Success'.tr));
      }
      // if (response == 'Unauthorised') {
      //   Get.back();
      //   Get.showSnackbar(Ui.ErrorSnackBar(message: "Credentials doesn't match".tr, title: "Error".tr));
      // } else {
      //   Get.offAllNamed(Routes.INFORMATION_FORM);
      //   //Get.offAllNamed(Routes.HOME);
      //   // Get.find<RootController>().changePageOutRoot(0);
      //   Get.showSnackbar(Ui.SuccessSnackBar(message: 'Successfully logged in'.tr, title: 'Success'.tr));
      // }
    });
  }

  getLocationPermission() async {

      LocationPermission permission;
      permission = await Geolocator.checkPermission();



      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }else{
        isLocationPermission.value = true;
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }


  }

  enableLocation() async {
    bool serviceEnabled;

    //LocationPermission permission;
    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    isLocationEnable.value = serviceEnabled;
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

  }

  get_dispatch_submit_list(BuildContext context) async {
    dispatchDrugList.clear();
    //var localdataSize2 = await dbHelper.queryAllDrugRows();
    var localdataSize2 = await dbHelper.get_tem_dispatch();

    print('localdataDrugSize: ${localdataSize2.length}');
    for (var i = 0; i < localdataSize2.length; i++) {
      Map<String, dynamic> map = localdataSize2[i];
      var drug_info = DispatchItem();
      drug_info.drug_name = map[DatabaseHelper.item_dispatch_medicine_name];
      drug_info.drug_id = map[DatabaseHelper.item_dispatch_medicine_id].toString();
      drug_info.dispatch_stock = map[DatabaseHelper.item_dispatch_quantity].toString();
      dispatchDrugList.add(drug_info);
    }
    print("drugList: "+dispatchDrugList.length.toString());
    if(dispatchDrugList.length > 0){
      submit_dispatch(context);
    }else{
      Utils.showToast('No data found');
    }

  }

  submit_dispatch(BuildContext context){
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);


    List<MedicineModel> medicineDetails = [];

    dispatchDrugList.forEach((element) {
      MedicineModel medicineModel = MedicineModel(int.parse(element.drug_id.toString()),int.parse(element.dispatch_stock.toString()),);
      medicineDetails.add(medicineModel);
    });

    //MedicineModel medicineModel = MedicineModel(1,15);
    //List<MedicineModel> medicineDetails = [MedicineModel(1,15),MedicineModel(1,15),MedicineModel(1,15)];
    // String jsonTags = jsonEncode(medicineDetails);
    // print(jsonTags);

    //SubmitDispatchModel submitDispatchModel = SubmitDispatchModel("1", "1", "1", "2022-05-06", medicineDetails);
    SubmitDispatchModel submitDispatchModel = SubmitDispatchModel( formattedDate, medicineDetails);
    String jsonTutorial = jsonEncode(submitDispatchModel);
    print('postjson: '+jsonTutorial.toString());
    postRequestDispatch(jsonEncode(submitDispatchModel),context);
    //return jsonTutorial;
  }

  Future<dynamic> postRequestDispatch (String data,BuildContext context) async {

    Ui.showLoaderDialog(context);
   // String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //String? token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdW5oY3J0ZXN0YXBpLmxhMzYwaG9zdC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjY2Nzg2NzUsImV4cCI6MTY2NjY4MjI3NSwibmJmIjoxNjY2Njc4Njc1LCJqdGkiOiIyeWdlZ2h3eDN4em15SDVrIiwic3ViIjoxNiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.FVCE70a3yE23PwRnmANVMdBUKzexcSuhKfRhoSdlkWg';
    print("token: ${token}");

    //var response = await http.post(Uri.parse(ApiClient.submit_dispatch),
    var response = await http.post(Uri.parse('https://unhcrtestapi.la360host.com/api/dispatch/savedata'),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );

    print("${response.statusCode}");
    print("${response.body}");

    var jsoObj = jsonDecode(response.body);

    var status = jsoObj['status'];
    print("status:${status}");
    if(status == 'success'){
      Utils.showToast('Data sync successful');
      dbHelper.deleteALlDrugs();
      dbHelper.deleteALlDispatch();
    }

    Navigator.of(context).pop();

    return response;
  }


}

class MedicineModel{
  var item_id = 0;
  var dispatch_qty = 0;
  MedicineModel(this.item_id, this.dispatch_qty);
  Map toJson() => {
    'item_id': item_id,
    'dispatch_qty': dispatch_qty,
  };

}

class SubmitDispatchModel{

  var dispatch_date = "";
  //var medicineDetails = "";
  List<MedicineModel> medicineDetails = [];

  SubmitDispatchModel(
      this.dispatch_date, this.medicineDetails);

  Map toJson() => {

    'dispatch_date': dispatch_date,
    'dispatchDetails': medicineDetails,

  };

}