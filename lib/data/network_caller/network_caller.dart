import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:http/http.dart';
import 'package:task_manager/ui/controller/authentication_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),headers: {'token':AuthenticationController.accessToken});
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccessFul: true,
          responseData: decodedData,
        );
      }
      else if(response.statusCode == 401)  {
        redirectToLogin;
        return NetworkResponse(statusCode: response.statusCode, inSuccessFul: false);
      }
      else  {
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccessFul: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, inSuccessFul: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic>? body) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-type': 'Application/json', 'token':AuthenticationController.accessToken},
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccessFul: true,
          responseData: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          inSuccessFul: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, inSuccessFul: false, errorMessage: e.toString());
    }
  }

 static Future<void> redirectToLogin() async {
    await AuthenticationController.clearAllData();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => SignInScreen()), (route) => false);
  }
}
