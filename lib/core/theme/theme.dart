import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/theme/colors.dart';
import 'package:recipe_finder_app/core/theme/text_theme.dart';

ThemeData buildAppTheme(BuildContext context) {
  final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: RFColors.deepOrange,
    onPrimary: RFColors.white,
    primaryContainer: RFColors.lightOrange,
    onPrimaryContainer: RFColors.darkOrangeBrown,
    secondary: RFColors.green,
    onSecondary: RFColors.white,
    secondaryContainer: RFColors.lightGreen,
    onSecondaryContainer: RFColors.darkGreen,
    tertiary: RFColors.brown,
    onTertiary: RFColors.white,
    tertiaryContainer: RFColors.lightBrown,
    onTertiaryContainer: RFColors.darkBrown,
    surface: RFColors.offWhite,
    onSurface: RFColors.nearBlack,
    error: RFColors.red,
    onError: RFColors.white,
    errorContainer: RFColors.lightRed,
    onErrorContainer: RFColors.darkRed,
    outline: RFColors.greyOutline,
    outlineVariant: RFColors.lightGreyOutline,
    shadow: RFColors.black,
    scrim: RFColors.black,
  );

  final baseTheme = ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  );

  final textTheme = buildAppTextTheme(context, baseTheme.textTheme);

  return baseTheme.copyWith(
    textTheme: textTheme,
    appBarTheme: _buildAppBarTheme(textTheme),
    floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
    cardTheme: _buildCardTheme(),
    chipTheme: _buildChipTheme(textTheme),
    inputDecorationTheme: _buildInputDecorationTheme(textTheme),
    dialogTheme: _buildDialogTheme(textTheme),
    bottomSheetTheme: _buildBottomSheetTheme(),
    progressIndicatorTheme: _buildProgressIndicatorTheme(),
    dividerTheme: _buildDividerTheme(),
  );
}

AppBarTheme _buildAppBarTheme(TextTheme textTheme) {
  return AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: RFColors.lightOrange,
    foregroundColor: RFColors.darkOrangeBrown,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: RFColors.deepOrange,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    titleTextStyle: textTheme.titleLarge?.copyWith(
      color: RFColors.darkOrangeBrown,
    ),
    iconTheme: IconThemeData(color: RFColors.darkOrangeBrown, size: 24.r),
  );
}

FloatingActionButtonThemeData _buildFloatingActionButtonTheme() {
  return FloatingActionButtonThemeData(
    backgroundColor: RFColors.lightOrange,
    foregroundColor: RFColors.darkOrangeBrown,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
  );
}

CardThemeData _buildCardTheme() {
  return CardThemeData(
    elevation: 1,
    color: RFColors.white,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    margin: EdgeInsets.all(8.r),
  );
}

ChipThemeData _buildChipTheme(TextTheme textTheme) {
  return ChipThemeData(
    backgroundColor: RFColors.lightGrey,
    deleteIconColor: RFColors.darkGrey,
    disabledColor: RFColors.nearBlack.withAlpha(31),
    selectedColor: RFColors.lightGreen,
    secondarySelectedColor: RFColors.lightGreen,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    labelStyle: textTheme.labelLarge,
    secondaryLabelStyle: textTheme.labelLarge,
    showCheckmark: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
      side: BorderSide.none,
    ),
  );
}

InputDecorationTheme _buildInputDecorationTheme(TextTheme textTheme) {
  return InputDecorationTheme(
    filled: true,
    fillColor: RFColors.lightGrey,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: RFColors.deepOrange, width: 2.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: RFColors.red, width: 1.w),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: RFColors.red, width: 2.w),
    ),
    labelStyle: textTheme.bodyLarge,
    hintStyle: textTheme.bodyLarge?.copyWith(
      color: RFColors.darkGrey.withAlpha(153),
    ),
    errorStyle: textTheme.bodySmall?.copyWith(color: RFColors.red),
  );
}

DialogThemeData _buildDialogTheme(TextTheme textTheme) {
  return DialogThemeData(
    surfaceTintColor: RFColors.lightGreen,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
    titleTextStyle: textTheme.headlineSmall,
    contentTextStyle: textTheme.bodyMedium,
  );
}

BottomSheetThemeData _buildBottomSheetTheme() {
  return BottomSheetThemeData(
    surfaceTintColor: RFColors.lightGreen,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
    ),
  );
}

ProgressIndicatorThemeData _buildProgressIndicatorTheme() {
  return ProgressIndicatorThemeData(
    color: RFColors.deepOrange,
    linearTrackColor: RFColors.lightOrange,
    circularTrackColor: RFColors.lightOrange,
  );
}

DividerThemeData _buildDividerTheme() {
  return DividerThemeData(
    color: RFColors.lightGreyOutline,
    thickness: 1.h,
    space: 1.h,
  );
}
