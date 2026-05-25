import 'package:bkash_payment_system/core/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? radius;
  final Color? borderColor;
  final bool? readOnly;
  final void Function()? onTap;
  final ValueChanged<String>? onChanged;
  final bool obsecureText;
  final TextInputType? textInputType;
  final String? errorText;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.obsecureText = false,
    this.textInputType,
    this.height,
    this.radius,
    this.borderColor,
    this.readOnly,
    this.onTap,
    this.errorText,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: maxLines != null && maxLines! > 1 ? null : (height ?? 57),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: hasError
                  ? Colors.red
                  : (borderColor ?? const Color(0xFFF7F8F8)),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius ?? 12),
          ),
          child: TextField(
            onTap: onTap,
            autofocus: false,
            controller: controller,
            obscureText: obsecureText,
            keyboardType: textInputType,
            onChanged: onChanged,
            readOnly: readOnly ?? false,
            cursorColor: Colors.grey,
            maxLines: maxLines ?? 1,
            enableInteractiveSelection: false,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            decoration: InputDecoration(
              hintText: hinText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: const Color(0xFFF7F8F8),
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: hasError
                    ? Colors.transparent
                    :AppColors.lightGreenColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        // Error message outside the border
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 6),
            child: Text(
              errorText!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}