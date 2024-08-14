import 'package:flutter/material.dart';
import 'package:totelx_machine_test/constants/app_colors.dart';

class AppTheme{
  ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor:AppColors.bgColor,
    appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    ) 
  );
}