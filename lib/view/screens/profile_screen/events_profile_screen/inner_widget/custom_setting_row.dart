// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tractivity_app/utils/app_colors/app_colors.dart';
import 'package:tractivity_app/view/components/custom_text/custom_text.dart';

class CustomSettingRow extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Function()? onTap;
  final double fontSize;
  final bool isTablet;
  const CustomSettingRow({
    super.key,
    required this.text,
    this.icon,
    this.color = Colors.black,
    this.textColor = Colors.black,
    this.onTap,
    this.fontSize = 16,
    this.isTablet =false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: isTablet?42:24,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
              text: text,
              fontSize: fontSize,
              color: textColor ?? AppColors.black,
              fontWeight: FontWeight.w600,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
