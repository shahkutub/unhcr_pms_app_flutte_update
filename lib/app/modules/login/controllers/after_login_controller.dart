import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
import '../../../api_providers/customExceptions.dart';
import '../../../models/CurrentStockRequestModel.dart';
import '../../../models/MedicineListResponse.dart';
import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../consumption_tally/controllers/consumption_tally_controller.dart';
import 'CurrentStockMedicineListResponse.dart';

class after_login_controller extends GetxController{
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
  final List<InternalItemModel> internalRequestSubmitList = <InternalItemModel>[];
  final List<InternalReceiveSubmitModel> internalReceiveSubmitList = <InternalReceiveSubmitModel>[];
  final List<MediReceiveDetailsModel> stockReceiveSubmitList = <MediReceiveDetailsModel>[];

  var dispensaryId = "";
  var facilityId = '';
  var partnerId = '';
  var totalConsumed = 0.obs;
  var totalPatientCount = 0.obs;

  //final List<ItemDispatchModel> itemList = <ItemDispatchModel>[].obs;
  final List<DispatchItem> drugList = <DispatchItem>[].obs;
  final List<DispatchItem> drugListMax = <DispatchItem>[].obs;

  var currentStockMedicineListResponse = CurrentStockMedicineListResponse().obs;
  var isStockSubmitted = false.obs;
  @override
  Future<void> onInit() async {
    //Get.find<AuthService>().setIsCurrentStockSubmitted(true);
    isStockSubmitted.value = Get.find<AuthService>().isStockSubmitted.value;

    print('IsCurrentStockSubmitted: '+isStockSubmitted.value.toString());

   // WidgetsBinding.instance.addObserver(this);
    print('after login home vie');


    var nlist = [1, 6, 8, 2, 16];
    nlist.sort((b, a) => a.compareTo(b));

    print('decnList'+nlist.toString());
    // get_drug_listFirst();
    // get_drug_listFromLocalDb();
    navigatorKey: navigatorKey;
    userNAme.value = Get.find<AuthService>().currentUser.value.data!.users!.username!.toString();
    userRole.value = Get.find<AuthService>().currentUser.value.data!.roles![0].role_name!;
    dispensaryId = Get.find<AuthService>().currentUser.value.data!.employee_info!.dispensary_id!;
    facilityId = Get.find<AuthService>().currentUser.value.data!.employee_info!.facility_id!;
    partnerId = Get.find<AuthService>().currentUser.value.data!.employee_info!.partner_id!;

    //get_drug_list();
    //getLocationPermission();
    //AuthRepository().allProd();

    reloadData();


    //get_current_stock();

    super.onInit();
  }

  onClose() {
    super.onClose();
    //WidgetsBinding.instance.removeObserver(this);
  }

  // @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);
  //   print('state = $state');
  //
  // }


  @override
  Future<void> onReady() async {
    // TODO: implement onReady

    super.onReady();
  }


  get_drug_list() async {
    drugList.clear();
    drugListMax.clear();
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


    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String todayDate = formatter.format(now);
    print(todayDate);

    String StockDate = 'no';
    var openingStockList = await dbHelper.queryAllOpeningStock();
    if(openingStockList.length > 0){
      Map<String, dynamic> map = openingStockList[0];
      StockDate = map[DatabaseHelper.date];
    }

    if(todayDate != StockDate){
      await dbHelper.delete_opening_stock();
      drugList.forEach((element) {
        Map<String, dynamic> row = {
          DatabaseHelper.date: todayDate,
          DatabaseHelper.drug_id: element.drug_id,
          DatabaseHelper.drug_name: element.drug_name,
          DatabaseHelper.drug_batch_no: element.batch_no,
          DatabaseHelper.drug_available_stock: element.available_stock,
        };

        dbHelper.insert_opening_stock(row);

      });
      var openingStockList = await dbHelper.queryAllOpeningStock();
      print('openingStockList: '+openingStockList.length.toString());

      //isStockSubmit = false
      Get.find<AuthService>().setIsCurrentStockSubmitted(false);
    }


    drugList.forEach((element) {
      totalConsumed.value = totalConsumed.value+int.parse(element.dispatch_stock.toString());


    });

    print("drugList: "+drugList.length.toString());

    // sort the data based on
    if (drugList != null && drugList.isNotEmpty) {
      drugList.sort((b, a) => a.dispatch_stock!.compareTo(b.dispatch_stock!));
    }
    //.sort((b, a) => a.compareTo(b));
// you can simply do this
    var lenth = drugList.length > 10 ? 10 : drugList.length;

    for( int i =0; i< lenth;i++){
    print('drugListMax'+drugList[i].dispatch_stock.toString());
    if(int.parse(drugList[i].dispatch_stock.toString())>0){
      drugListMax.add(drugList[i]);
    }

    }

    //drugListMax.reversed;
    update();
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
      MedicineModel medicineModel = MedicineModel(int.parse(element.drug_id.toString()),int.parse(element.dispatch_stock.toString()));
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

    var response = await http.post(Uri.parse(ApiClient.submit_dispatch),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );

    print("statusCode: ${response.statusCode}");
    if(response.statusCode == 500){
      //logout();
      Get.offAllNamed(Routes.LOGIN);
    }
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
      Utils.showToastAlert('Server error');
      Get.offAllNamed(Routes.LOGIN);
    }

    print("${response.body}");

    var jsoObj = jsonDecode(response.body);

    var status = jsoObj['status'];
    print("status:${status}");
    if(status == 'success'){
      Utils.showToast('Internal request upload successful');
      dbHelper.delete_internal_request();

    }

    Navigator.of(context).pop();

    return response;
  }


  Future<dynamic> submit_stock_receive(String data,BuildContext context) async {

    Ui.showLoaderDialog(context);
    // String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
    var headers = {'Authorization': 'Bearer $token'};
    //String? token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdW5oY3J0ZXN0YXBpLmxhMzYwaG9zdC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjY2Nzg2NzUsImV4cCI6MTY2NjY4MjI3NSwibmJmIjoxNjY2Njc4Njc1LCJqdGkiOiIyeWdlZ2h3eDN4em15SDVrIiwic3ViIjoxNiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.FVCE70a3yE23PwRnmANVMdBUKzexcSuhKfRhoSdlkWg';
    print("token: ${token}");

    var response = await http.post(Uri.parse(ApiClient.submit_stock_receive),
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
        body: data
    );

    print("statusCode: ${response.statusCode}");
    if(response.statusCode == 500){
      Utils.showToastAlert('Server error');
      //logout();
      Get.offAllNamed(Routes.LOGIN);
    }

    print("${response.body}");

    var jsoObj = jsonDecode(response.body);

    var status = jsoObj['status'];
    print("status:${status}");
    if(status == 'success'){
      Utils.showToast('Stock receive upload successful');
      dbHelper.delete_internal_request();

    }

    Navigator.of(context).pop();

    return response;
  }

  Future<dynamic> get_current_stock() async {

    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.back();
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{

      var data = CurrentStockRequestModel(dispensary_ids: [int.parse(dispensaryId)],
          facility_ids:[int.parse(facilityId)] , layer: '5',partner_ids: [int.parse(partnerId)]);
      String jsonData = jsonEncode(data);
      print('json: '+jsonData.toString());

      //Ui.showLoaderDialog(context);
      // String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
      String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
      var headers = {'Authorization': 'Bearer $token'};
      //String? token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdW5oY3J0ZXN0YXBpLmxhMzYwaG9zdC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjY2Nzg2NzUsImV4cCI6MTY2NjY4MjI3NSwibmJmIjoxNjY2Njc4Njc1LCJqdGkiOiIyeWdlZ2h3eDN4em15SDVrIiwic3ViIjoxNiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.FVCE70a3yE23PwRnmANVMdBUKzexcSuhKfRhoSdlkWg';
      print("token: ${token}");

      var response = await http.post(Uri.parse(ApiClient.current_stock_list),
          headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token'},
          body: jsonData
      );

      print("statusCode: ${response.statusCode}");
      if(response.statusCode == 500){
        Utils.showToastAlert('Server error');
        //logout();
        Get.offAllNamed(Routes.LOGIN);
      }
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body.toString());

        currentStockMedicineListResponse.value = CurrentStockMedicineListResponse.fromJson(jsonResponse);
        if(currentStockMedicineListResponse.value.current_stock_info!.length == 0){
          //Get.back();
          Get.showSnackbar(Ui.defaultSnackBar(message: 'No Current stock data found'));
        }else{
          currentStockSaveToDB();
        }

        //return new StockReceiveResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data!');
      }
      //Navigator.of(context).pop();

      return response;
    }

  }

  getInitialStockApicall() async {
    //print("Calling API: $url");

    if(!await (Utils.checkConnection() as Future<bool>)){
      debugPrint('No internet connection');
      Get.back();
      Get.showSnackbar(Ui.internetCheckSnackBar(message: 'No internet connection'));
    }else{
      String? token = Get.find<AuthService>().currentUser.value.data!.access_token;
      var headers = {'Authorization': 'Bearer $token'};
      var responseJson;
      try {
        final response = await http.get(Uri.parse(ApiClient.drug_list),headers: headers);
        print('statuscode: '+response.statusCode.toString());
        print('drug_list: '+response.body.toString());
        if(response.statusCode == 500){
          Get.showSnackbar(Ui.defaultSnackBar(message: 'Authentication field'));
          Get.toNamed(Routes.LOGIN);
        }
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body.toString());

          //  List<dynamic> distribution_list = jsonResponse['distribution_list'];
          // if(distribution_list.length == 0){
          //   Get.back();
          //   Get.showSnackbar(Ui.defaultSnackBar(message: 'No data found'));
          // }

          druglistResonse.value = MedicineListResponse.fromJson(jsonResponse);
          if(druglistResonse.value.dispatch_items!.length == 0){
            //Get.back();
            Get.showSnackbar(Ui.defaultSnackBar(message: 'No Medicine found'));
          }else{
            currentStockSaveToDB();
          }

          //return new StockReceiveResponse.fromJson(jsonResponse);
        } else {
          throw Exception('Failed to load data!');
        }
        //responseJson = _response(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    }

  }

  void currentStockSaveToDB(){


      druglistResonse.value.dispatch_items!.forEach((element) async {
        Map<String, dynamic> row = {
          DatabaseHelper.drug_name: element.drug_name,
          DatabaseHelper.drug_id: element.drug_id,
          DatabaseHelper.drug_available_stock: element.available_stock,
          DatabaseHelper.drug_stock_receive: '0',
          DatabaseHelper.drug_stock_consume: '0',
          DatabaseHelper.drug_stock_lose: '0',
          DatabaseHelper.drug_reject_reason: '',
          DatabaseHelper.drug_batch_no: element.batch_no,
          DatabaseHelper.drug_receive_type: '1',
          DatabaseHelper.stockout_master_id: '',
        };

        await dbHelper.insert_drug(row);
      });



      reloadData();
  }



  void logout() {
    Get.find<AuthService>().removeCurrentUser();
    dbHelper.deleteALlDrugs();
    dbHelper.deleteALlDispatch();
    dbHelper.deletePserial();
    dbHelper.delete_internal_request();
    Get.offAllNamed(Routes.LOGIN);

  }


 get_internal_request_list(BuildContext context) async {
   internalRequestSubmitList.clear();
   var now = new DateTime.now();
   var formatter = new DateFormat('yyyy-MM-dd');
   String formattedDate = formatter.format(now);
   print(formattedDate);
    //var localdataSize2 = await dbHelper.queryAllDrugRows();
    var internalReqSize = await dbHelper.get_internal_request();

    print('internalReqSize: ${internalReqSize.length}');
    for (var i = 0; i < internalReqSize.length; i++) {
      Map<String, dynamic> map = internalReqSize[i];
      var drug_info = InternalItemModel(map[DatabaseHelper.internal_req_med_id],
          map[DatabaseHelper.internal_req_qty],
          map[DatabaseHelper.internal_req_remark],
          map[DatabaseHelper.internal_req_date],
          map[DatabaseHelper.internal_req_serial]);
      internalRequestSubmitList.add(drug_info);
    }
    print("internalRequestSubmitList: "+internalRequestSubmitList.length.toString());

   InternalRequestSubmitModel submitDispatchModel = InternalRequestSubmitModel( int.parse(dispensaryId ), int.parse(facilityId),int.parse(partnerId),formattedDate,internalRequestSubmitList,'offline');
   String jsonData = jsonEncode(submitDispatchModel);
   print('internalRequestjson: '+jsonData.toString());

   if(internalRequestSubmitList.length>0){
     postInternalRequest( jsonData,context);
   }


  }

  get_stock_receive_submitdata(BuildContext context) async {

    var internalReqSize = await dbHelper.queryAllDrugRows();

    print('internalReqSize: ${internalReqSize.length}');
    for (var i = 0; i < internalReqSize.length; i++) {
      Map<String, dynamic> map = internalReqSize[i];
      var receiveType =  map[DatabaseHelper.drug_receive_type];
      if(receiveType == '1'){
        var drug_info = MediReceiveDetailsModel(
          map[DatabaseHelper.drug_id],
          map[DatabaseHelper.drug_stock_receive],
          map[DatabaseHelper.drug_stock_lose].toString().isEmpty?'0':map[DatabaseHelper.drug_stock_lose].toString(),
          map[DatabaseHelper.drug_reject_reason],
        );
        stockReceiveSubmitList.add(drug_info);
      }


    }
    print("stockReceiveSubmitList: "+stockReceiveSubmitList.length.toString());

    Map<String, dynamic> map = internalReqSize[0];
    var stockout_master_id = map[DatabaseHelper.stockout_master_id];
    print('stockout_master_id: ${stockout_master_id}');

    StockReceiveSubmitModel submitDispatchModel = StockReceiveSubmitModel( stockout_master_id, stockReceiveSubmitList);
    String jsonData = jsonEncode(submitDispatchModel);
    print('stockreceivejson: '+jsonData.toString());

    if(stockReceiveSubmitList.length>0){
      submit_stock_receive( jsonData,context);
    }


  }

  get_internal_receive_submitdata(BuildContext context) async {

    var internalReqSize = await dbHelper.queryAllDrugRows();

    print('internalReqSize: ${internalReqSize.length}');
    for (var i = 0; i < internalReqSize.length; i++) {
      Map<String, dynamic> map = internalReqSize[i];
      var receiveType =  map[DatabaseHelper.drug_receive_type];
      if(receiveType == 2){
        var drug_info = MediReceiveDetailsModel(
          map[DatabaseHelper.drug_id],
          map[DatabaseHelper.drug_stock_receive],
          map[DatabaseHelper.drug_stock_lose],
          map[DatabaseHelper.drug_reject_reason],
        );
        stockReceiveSubmitList.add(drug_info);
      }


    }
    print("stockReceiveSubmitList: "+stockReceiveSubmitList.length.toString());

    Map<String, dynamic> map = internalReqSize[0];
    var stockout_master_id = map[DatabaseHelper.stockout_master_id];
    print('stockout_master_id: ${stockout_master_id}');
    StockReceiveSubmitModel submitDispatchModel = StockReceiveSubmitModel( stockout_master_id, stockReceiveSubmitList);
    String jsonData = jsonEncode(submitDispatchModel);
    print('stockreceivejson: '+jsonData.toString());

    //submit_stock_receive( jsonData,context);

  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  Future<void> onResumed() async {

  }

  reloadData() async {
    isStockSubmitted.value = Get.find<AuthService>().isStockSubmitted.value;
    totalConsumed.value = 0;
    get_drug_list();
    var localdataSize = await dbHelper.getAllPatientSerialCountAll();
    totalPatientCount.value = localdataSize.length;
    //update();

    if(drugList.length == 0){
      getInitialStockApicall();
    }
  }

}

class StockReceiveSubmitModel{
  var  stockout_master_id = '';
  List<MediReceiveDetailsModel> medicine_details = [];
  StockReceiveSubmitModel(this.stockout_master_id,this.medicine_details);

  Map toJson() => {
    'stockout_master_id': stockout_master_id,
    'medicine_details': medicine_details
  };
}

class MediReceiveDetailsModel {

  var drug_id = '';
  var received_qty = '';
  var rejected_qty = '';
  var rejected_reason = '';
  MediReceiveDetailsModel(this.drug_id,this.received_qty, this.rejected_qty,this.rejected_reason);
  Map toJson() => {
    'drug_id': drug_id,
    'received_qty': received_qty,
    'rejected_qty': rejected_qty,
    'rejected_reason': rejected_reason,
  };

}

class InternalRequestSubmitModel {

  var  dispensary_id = 0;
  var  facility_id = 0;
  var  partner_id = 0;
  var  date = "";
  var  request_mode = "";
  List<InternalItemModel> itemDetails = [];
  InternalRequestSubmitModel(this.dispensary_id,this.facility_id,this.partner_id,this.date,this.itemDetails,this.request_mode,);
  Map toJson() => {
    'dispensary_id': dispensary_id,
    'facility_id': facility_id,
    'partner_id': partner_id,
    'date': date,
    'request_mode': request_mode,
    'itemDetails': itemDetails,
  };


}

class InternalItemModel {

  var item_id = 0;
  var req_qty = 0;
  var remark = '';
  var date = '';
  var serial = '';
  InternalItemModel(this.item_id, this.req_qty,this.remark,this.date,this.serial,);
  Map toJson() => {
    'item_id': item_id,
    'req_qty': req_qty,
    'remark': remark,
    'date': date,
    'serial': serial,
  };

}

class InternalReceiveSubmitModel {

  var item_id = 0;
  var req_qty = 0;
  var remark = '';
  var date = '';
  var serial = '';
  InternalReceiveSubmitModel(this.item_id, this.req_qty,this.remark,this.date,this.serial,);
  Map toJson() => {
    'item_id': item_id,
    'req_qty': req_qty,
    'remark': remark,
    'date': date,
    'serial': serial,
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

