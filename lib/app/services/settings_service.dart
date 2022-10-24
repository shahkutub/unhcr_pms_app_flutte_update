import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/ui.dart';

import 'translation_service.dart';

class SettingsService extends GetxService {
  late GetStorage _box;

  SettingsService() {
    _box = GetStorage();
  }

  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        //primaryColor: Color(0xffec008c),
        primaryColor: Colors.green,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.green,
        ),
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        accentColor: Colors.green,
        dividerColor: Colors.grey.shade800,
        focusColor: Colors.green,
        hintColor: Colors.grey,
        splashColor: Colors.grey.shade200,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.green,
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        colorScheme: ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.green,
        ),
        textTheme: GoogleFonts.getTextTheme(
            'Poppins',
            TextTheme(
              headline6: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
              headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
              headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black, height: 1.3),
              headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.3),
              headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.black, height: 1.4),
              headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.black, height: 1.4),
              subtitle2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.2),
              subtitle1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.black, height: 1.2),
              bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.black, height: 1.2),
              bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.black, height: 1.2),
              caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.black, height: 1.2),
            )));
  }

  ThemeData getDarkTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Colors.blue,
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.blue),
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        dividerColor: Colors.white38,
        focusColor: Colors.blue,
        hintColor: Colors.white38,
        toggleableActiveColor: Colors.blue,
        splashColor: Color(0xFF2C2C2C),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.white38,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2C2C2C),
        ),
        textTheme: GoogleFonts.getTextTheme(
            "Poppins",
            TextTheme(
              headline6: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.blue, height: 1.3),
              headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.blue, height: 1.3),
              headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white, height: 1.3),
              headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white, height: 1.3),
              headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.blue, height: 1.4),
              headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.white, height: 1.4),
              subtitle2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2),
              subtitle1: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.blue, height: 1.2),
              bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: Colors.white, height: 1.2),
              bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white, height: 1.2),
              caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: Colors.blue, height: 1.2),
            )));
  }

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      default:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.light;
    }
  }

  Locale getLocale() {
    String? _locale = GetStorage().read<String>('language');
    print(_locale);
    if (_locale == null || _locale.isEmpty) {
      _locale = 'bn_BD';
    }
    return Get.find<TranslationService>().fromStringToLocale(_locale);
  }
}
