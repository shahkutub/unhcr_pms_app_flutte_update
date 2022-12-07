
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class Utils {


  static showToastAlert(String s) {
    Get.snackbar(
        "Alert!",
        ""+s,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
    );
  }

  static showToast(String s) {
    Get.snackbar(
        "!",
        ""+s,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }

  static showToastWithTitle(String title,String msg) {
    Get.snackbar(
        ""+title,
        ""+msg,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
    );
  }

  static Future<bool> checkConnection() async{

    ConnectivityResult connectivityResult = await (new Connectivity().checkConnectivity());

    debugPrint(connectivityResult.toString());

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)){
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  static String replaceEngNumberToBangla(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    //০১২৩৪৫৬৭৮৯
    const bang = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], bang[i]);
    }

    return input;
  }

  static String replaceEngDayNameBangla() {

    var input = "";
    const bang = ['সোমবার' ,'মঙ্গলবার', 'বুধবার', 'বৃহস্পতিবার', 'শুক্রবার','শনিবার','রবিবার'];
    const english = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    var someDateTime = new DateTime.now();
    var mon = someDateTime.weekday;
    input = bang[mon-1];
    print("weekday is ${input}");


    // for (int i = 0; i < english.length; i++) {
    //   input = input.replaceAll(english[i], bang[i]);
    // }

    return input;
  }

  static String replaceEngMonthNameBangla() {
    var input = "";
    List months = ['jan','feb','mar','april','may','jun','july','aug','sep','oct','nov','dec'];

    var someDateTime = new DateTime.now();
    var mon = someDateTime.month;
    input = months[mon-1];
    //০১২৩৪৫৬৭৮৯
    const bang = ["জানুয়ারী","ফেব্রুয়ারি","মার্চ","এপ্রিল","মে","জুন","জুলাই","অগাস্ট","সেপ্টেম্বর","অক্টবর","নভেম্বর","ডিসেম্বর"];

    for (int i = 0; i < months.length; i++) {
      input = input.replaceAll(months[i], bang[i]);
    }
    print(input);
    return input;
  }

  static String getCurrentDate(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String currentDateBengali(){

    const bangMonths = ["জানুয়ারী","ফেব্রুয়ারি","মার্চ","এপ্রিল","মে","জুন","জুলাই","অগাস্ট","সেপ্টেম্বর","অক্টবর","নভেম্বর","ডিসেম্বর"];
    const bangDayNames = ['সোমবার' ,'মঙ্গলবার', 'বুধবার', 'বৃহস্পতিবার', 'শুক্রবার','শনিবার','রোববার'];
    var date_str = "";
    var monthBngStr = "";
    var dayNameBngStr = "";
    var dayBngStr = "";

    var someDateTime = new DateTime.now();
    var monthInt = someDateTime.month;
    var dayNameInt = someDateTime.weekday;
    var dayInt = someDateTime.day;
    var yearInt = someDateTime.year;

    dayBngStr = replaceEngNumberToBangla(dayInt.toString());
    print(dayBngStr);

    monthBngStr = bangMonths[monthInt-1];
    print(monthBngStr);

    dayNameBngStr = bangDayNames[dayNameInt-1];
    print(dayNameBngStr);
    //input = months[mon-1];
    date_str = dayNameBngStr+', '+dayBngStr+' '+monthBngStr+' '+replaceEngNumberToBangla(yearInt.toString());
    print(date_str);
    return date_str;
  }


}