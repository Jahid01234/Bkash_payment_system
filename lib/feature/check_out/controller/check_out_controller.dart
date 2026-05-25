import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutController extends GetxController{
  final TextEditingController amountController = TextEditingController();
  final TextEditingController invoiceNumberController = TextEditingController();



  @override
  void dispose() {
    amountController.dispose();
    invoiceNumberController.dispose();
    super.dispose();
  }
}