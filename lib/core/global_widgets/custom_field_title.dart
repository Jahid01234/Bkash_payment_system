import 'package:bkash_payment_system/core/const/app_colors.dart';
import 'package:bkash_payment_system/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class CustomFieldTitle extends StatelessWidget {
  final String title;

  const CustomFieldTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: globalTextStyle(
          fontSize: 16,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500
      ),
    );
  }
}