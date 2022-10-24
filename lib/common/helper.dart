import 'dart:convert' as convert;
import 'dart:io' as io;

import 'package:flutter/services.dart';

class Helper {
  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  String lonConversion(double longitude) {
    int longSeconds = (longitude * 3600).toInt();
    int longDegrees = (longSeconds / 3600).toInt();
    longSeconds = (longSeconds % 3600).abs();
    int longMinutes = (longSeconds / 60).toInt();
    longSeconds %= 60;
    String lonDegrees = longDegrees >= 0 ? "E" : "W";

    return '${longDegrees.abs()}' +
        "°" +
        '$longMinutes' +
        "'" +
        '$longSeconds' +
        "\"" +
        lonDegrees;
  }

  String latConversion(double latitude) {
    int latSeconds = (latitude * 3600).toInt();
    int latDegrees = (latSeconds / 3600).toInt();
    latSeconds = (latSeconds % 3600).abs();
    int latMinutes = (latSeconds / 60).toInt();
    latSeconds %= 60;
    String latDegree = latDegrees >= 0 ? "N" : "S";

    return '${latDegrees.abs()}' +
        "°" +
        '$latMinutes' +
        "'" +
        '$latSeconds' +
        "\"" +
        latDegree;
  }
}
