import 'package:flutter/material.dart';
import 'package:totelx_machine_test/constants/app_colors.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';

class AppTheme{
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor:AppColors.bgColor,
    appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    ) ,
    // textTheme: TextTheme(
    //   titleLarge: AppTextStyles.headline,
    //   titleMedium: AppTextStyles.subtitle,
    //   button: AppTextStyles.button,


    // )
  );
}