import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bkash_payment_system/core/const/app_secret.dart';
import 'package:bkash_payment_system/core/network_caller/end_points.dart';
import 'package:bkash_payment_system/feature/check_out/model/grant_token_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController invoiceNumberController = TextEditingController();

  // Grant Token method.........................................................
  Future<GrantTokenResponseModel?> grantToken() async {
    EasyLoading.show(status: "Loading...");
    String url = Urls.grantTokenUrl;

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "username": AppSecret.grantTokenUserName,
          "password": AppSecret.grantTokenUserPassword,
        },
        body: jsonEncode({
          "app_key": AppSecret.grantTokenAppKey,
          "app_secret": AppSecret.grantTokenAppSecret
        }),
      );

      log("Response Urls: $url");
      log("Response status code: ${response.statusCode}");
      log("Response body: ${response.body}");

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return GrantTokenResponseModel.fromJson(response.body);
      }else{
        EasyLoading.showError(responseData["statusMessage"] ?? "Something went wrong");
      }
    } on SocketException {
      log("No Internet connection");
      EasyLoading.showError("No Internet connection. Please check your network.");
    } on TimeoutException {
      log("Request timed out");
      EasyLoading.showError("Server is taking too long to respond. Please try again later.");
    } on HttpException {
      log("HTTP Exception occurred");
      EasyLoading.showError("Something went wrong. Please try again.");
    } on FormatException {
      log("Invalid JSON format");
      EasyLoading.showError("Server response was not in the expected format.");
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }



  @override
  void dispose() {
    amountController.dispose();
    invoiceNumberController.dispose();
    super.dispose();
  }
}