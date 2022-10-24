import 'package:brac_arna/app/models/LoginDataResponse.dart';
import 'package:brac_arna/app/models/LoginResponse.dart';
import 'package:brac_arna/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'settings_service.dart';

class AuthService extends GetxService {
  //final currentUser = LoginResponse().obs;
  final currentUser = LoginDataResponse().obs;
  late GetStorage _box;

  AuthService() {
    _box = GetStorage();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    _box = GetStorage();
    await getCurrentUser();
    super.onInit();
  }

  // Future<AuthService> init() async {
  //   user.listen((UserModel _user) {
  //     if (Get.isRegistered<SettingsService>()) {
  //       Get.find<SettingsService>().address.value.userId = _user.id;
  //     }
  //     _box.write('current_user', _user.toJson());
  //   });
  //   await getCurrentUser();
  //   return this;
  // }

  // void setUser(LoginResponse user) async {
  //   _box.write('current_user', user.toJson());
  //
  //   await getCurrentUser();
  // }

  void setUser(LoginDataResponse user) async {
    _box.write('current_user', user.toJson());

    await getCurrentUser();
  }

  Future getCurrentUser() async {
    if (_box.hasData('current_user')) {
      currentUser.value = LoginDataResponse.fromJson(await _box.read('current_user'));
    }
    //print('customer data: ${currentUser.value.data?.user!.username}');
  }

  // Future getCurrentUser() async {
  //   if (_box.hasData('current_user')) {
  //     currentUser.value = LoginResponse.fromJson(await _box.read('current_user'));
  //   }
  //   //print('customer data: ${currentUser.value.data?.user!.username}');
  // }

  Future removeCurrentUser() async {
    currentUser.value = LoginDataResponse();
    await _box.remove('current_user');
  }

  // Future removeCurrentUser() async {
  //   currentUser.value = LoginResponse();
  //   await _box.remove('current_user');
  // }

  bool get isAuth => currentUser.value.data!.access_token == null ? false : true;

  //bool get isAdmin => currentUser.value.roleName == 'admin_api' ? true : false;

  String? get apiToken => currentUser.value.data!.access_token;
}