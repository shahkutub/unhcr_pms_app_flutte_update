import 'package:brac_arna/app/services/auth_service.dart';
import 'package:brac_arna/app/services/settings_service.dart';
import 'package:brac_arna/app/services/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

initServices() async {
  Get.log('starting services ...');
  await Hive.initFlutter();
  await Hive.openBox('formBox');
  await GetStorage.init();
  await Get.putAsync<SettingsService>(() async => await SettingsService());

  await Get.putAsync<AuthService>(() async => await AuthService());
  await Get.putAsync(() => TranslationService().init());

  Get.log('All services started...');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<SettingsService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().fallbackLocale,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<SettingsService>().getThemeMode(),
      //theme: ThemeData(fontFamily: 'SolaimanLipi'),
      //theme: Get.find<SettingsService>().getLightTheme(),
      //darkTheme: Get.find<SettingsService>().getDarkTheme(),
    ),
  );
}