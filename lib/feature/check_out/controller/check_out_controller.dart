import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bkash_payment_system/core/const/app_secret.dart';
import 'package:bkash_payment_system/core/network_caller/end_points.dart';
import 'package:bkash_payment_system/feature/check_out/model/create_payment_response_model.dart';
import 'package:bkash_payment_system/feature/check_out/model/execute_payment_response_model.dart';
import 'package:bkash_payment_system/feature/check_out/model/grant_token_response_model.dart';
import 'package:bkash_payment_system/feature/payment/view/payment_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController invoiceNumberController = TextEditingController();


  // check out button...........................................................
  Future<void> checkoutButton() async {

    final tokenResponse = await grantToken();
    if (tokenResponse == null) return;

    final paymentResponse = await createPaymentMethod(tokenResponse.idToken);
    if (paymentResponse == null) return;

    Get.to(() => PaymentScreen(
      bkashURL: paymentResponse.bkashURL,
      paymentID: paymentResponse.paymentID,
      idToken: tokenResponse.idToken,
    ));

    EasyLoading.showSuccess("Payment Created");

    debugPrint("Payment ID: ${paymentResponse.paymentID}");
  }

  // Grant Token method.........................................................
  Future<GrantTokenResponseModel?> grantToken() async {
    EasyLoading.show(status: "Loading...");
    final String url = Urls.grantTokenUrl;

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
      log("❤️❤️❤️Grant Token Response body: ${response.body}");

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

  // Create payment method.........................................................
  Future<CreatePaymentResponseModel?> createPaymentMethod(String idToken) async {
    final String url = Urls.createPaymentUrl;

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": idToken,
          "X-App-Key":  AppSecret.grantTokenAppKey,
        },
        body: jsonEncode({
            "mode": "0011",
            "payerReference": "01770618576",
            "callbackURL": "https://tcean.store",
            "amount": amountController.text.trim(),
            "currency": "BDT",
            "intent": "sale",
            "merchantInvoiceNumber": invoiceNumberController.text.trim(),
        }),
      );

      log("Response Urls: $url");
      log("Response status code: ${response.statusCode}");
      log("🌸🌸🌸Create Payment Response body: ${response.body}");

      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        amountController.clear();
        invoiceNumberController.clear();
        return CreatePaymentResponseModel.fromJson(response.body);
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

  // Execute Payment method.....................................................
  Future<ExecutePaymentResponseModel?> executePayment(String paymentID, String idToken) async {
    final String url = Urls.executePaymentUrl;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": idToken,
          "X-App-Key": AppSecret.grantTokenAppKey,
        },
        body: jsonEncode({
          "paymentID": paymentID,
        }),
      );

      log("Execute Payment URL: ${Urls.executePaymentUrl}");
      log("Status Code: ${response.statusCode}");
      log("🔥🔥🔥Execute Payment Response: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ExecutePaymentResponseModel.fromJson(response.body);
      } else {
        EasyLoading.showError(
          responseData["statusMessage"] ?? "Payment execution failed",
        );
      }
    } on SocketException {
      EasyLoading.showError(
        "No Internet connection. Please check your network.",
      );
    } on TimeoutException {
      EasyLoading.showError(
        "Server is taking too long to respond.",
      );
    } on HttpException {
      EasyLoading.showError(
        "HTTP Exception occurred.",
      );
    } on FormatException {
      EasyLoading.showError(
        "Invalid response format.",
      );
    } catch (e) {
      log("Execute Payment Error: $e");
      EasyLoading.showError(
        "Something went wrong.",
      );
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