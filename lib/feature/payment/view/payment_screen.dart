import 'package:bkash_payment_system/core/const/app_colors.dart';
import 'package:bkash_payment_system/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Pay with Bkash",
          style: globalTextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
      ),

    );
  }
}
