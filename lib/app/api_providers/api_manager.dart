import 'dart:convert';
import 'dart:io';

import 'package:brac_arna/app/api_providers/customExceptions.dart';
import 'package:http/http.dart' as http;

class APIManager {
  Future<dynamic> postAPICallWithHeader(String url, Map param, Map<String, String> headerData) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: param, headers: headerData);
      print(response.body);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICallWithHeaderWithoutParam(String url, Map<String, String> headerData) async {
    print("Calling API: $url");
   // print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), headers: headerData);
      print(response.body);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICall(String url, Map param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: param);
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPIloaginCall(String url, Map param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: param);
      responseJson = _response(response);
      print(responseJson);

      // Map<String, dynamic> user = jsonDecode(responseJson.body);
      // var datanews = jsonEncode(user['data']);
      //
      // Map<String, dynamic> data = jsonDecode(datanews);
      // var access_token = data['access_token'];
      // print('access_token: '+access_token);

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(String url,Map<String, String> headerData) async {
    print("Calling API: $url");
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),headers: headerData);
      print(response.body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred while communicating with Server with StatusCode: ${response.statusCode}');
    }
  }
}