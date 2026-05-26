import 'package:bkash_payment_system/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  configEasyLoading();
  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.green
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

