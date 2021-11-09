import 'dart:convert';
import 'dart:io';

import 'package:e_citizen/consts/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class Utils {
  static Future<List> getCodeFromRegister({
    required String cardId,
    required String cardType,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      String? deviceId;
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      } else {}
      final Map bodyMap = {
        'idNum': cardId,
        'idType': cardType,
        'lastname': name.toUpperCase(),
        'deviceId': deviceId ?? "",
        //TODO: ASKS WHAT TO SEND IF DEVICEID IS NULL
        'msisdn': phoneNumber
      };
      print(bodyMap);
      http.Response response =
          await http.post(Uri.parse(AppRoutes.phoneRegister), body: bodyMap);
      print(response.statusCode.toString() + '\n' + response.body.toString());
      if (response.statusCode.toString().startsWith('20')) {
        if (jsonDecode(response.body)['success']) {
          return [
            true,
            (jsonDecode(response.body)['data'])['token'],
            (jsonDecode(response.body)['data'])['OTP'],
          ];
        } else {
          return [false, jsonDecode(response.body)['message']];
        }
      } else {
        return [false];
      }
    } catch (e) {
      return [null];
    }
  }

  static Future<List> getCodeFromLogin({
    required String phoneNumber,
  }) async {
    try {
      String? deviceId;
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      } else {}
      final Map bodyMap = {
        'deviceId': deviceId ?? "",
        //TODO: ASKS WHAT TO SEND IF DEVICEID IS NULL
        'msisdn': phoneNumber
      };
      print(bodyMap);
      http.Response response =
          await http.post(Uri.parse(AppRoutes.phoneLogin), body: bodyMap);
      print(response.statusCode.toString() + '\n' + response.body.toString());
      if (response.statusCode.toString().startsWith('20')) {
        if (jsonDecode(response.body)['success']) {
          return [
            true,
            (jsonDecode(response.body)['data'])['token'],
            (jsonDecode(response.body)['data'])['OTP'],
          ];
        } else {
          return [false, jsonDecode(response.body)['message']];
        }
      } else {
        return [false];
      }
    } catch (e) {
      return [null];
    }
  }

  static showAppErrorSnackbar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black87,
          duration: const Duration(seconds: 4),
          content: Text(
            "L'action n'a pu être réalisée, veuillez éssayer ultérieurement. Merci de contacter le service client si l'erreur persiste.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.yellow.shade800),
          ),
        ),
      );

  static showErrorSnackbar(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black87,
          duration: const Duration(seconds: 4),
          content: Text(
            "L'action a été refusée. Pas d'inquiétude, vérifiez d'être connecté et réessayez. Merci de contacter le service client si l'erreur persiste.",
            style: TextStyle(
              color: Colors.yellow.shade800,
            ),
          ),
        ),
      );

  static double fullHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double fullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static String logTruncate(String text) {
    var len = 128;
    if (text.length > len) {
      text = text.substring(0, len);
    }
    return text;
  }
}
