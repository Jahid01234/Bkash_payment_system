import 'package:bkash_payment_system/core/const/app_colors.dart';
import 'package:bkash_payment_system/core/global_widgets/app_primary_button.dart';
import 'package:bkash_payment_system/core/global_widgets/custom_field_title.dart';
import 'package:bkash_payment_system/core/global_widgets/custom_text_field.dart';
import 'package:bkash_payment_system/core/style/global_text_style.dart';
import 'package:bkash_payment_system/feature/check_out/controller/check_out_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
   CheckOutScreen({super.key});

  final CheckOutController controller = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Check Out",
          style: globalTextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20) ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            CustomFieldTitle(title: "Amount"),
            SizedBox(height: 4),
            CustomTextField(
              controller: controller.amountController,
              hinText: "Enter Amount",
              textInputType: TextInputType.number,
              prefixIcon: const Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: 20),
            CustomFieldTitle(title: "Invoice Number"),
            SizedBox(height: 4),
            CustomTextField(
              controller: controller.invoiceNumberController,
              hinText: "Enter Invoice Number",
              textInputType: TextInputType.text,
              prefixIcon: const Icon(
                  Icons.add_chart_outlined,
                  color: AppColors.greyColor,
              ),
            ),
            SizedBox(height: 150),
            AppPrimaryButton(
              text: "Check out",
              textColor: AppColors.whiteColor,
              // isLoading: controller.isLoading.value,
              onTap:(){
              },
            ),
          ],
        ),
      ),
    );
  }
}
