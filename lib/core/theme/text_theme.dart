import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/theme/colors.dart';

TextTheme buildAppTextTheme(BuildContext context, TextTheme base) {
  return base
      .copyWith(
        displayLarge: TextStyle(
          fontSize: 57.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.nearBlack,
        ),
        displayMedium: TextStyle(
          fontSize: 45.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.nearBlack,
        ),
        displaySmall: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.nearBlack,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        titleLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: RFColors.nearBlack,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.nearBlack,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.nearBlack,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: RFColors.darkGrey,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: RFColors.nearBlack,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: RFColors.nearBlack,
        ),
        labelSmall: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: RFColors.darkGrey,
        ),
      )
      .apply(fontFamily: 'PlusJakartaSans');
}
