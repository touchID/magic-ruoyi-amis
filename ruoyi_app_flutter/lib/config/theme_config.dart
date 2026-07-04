import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF409EFF),
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF409EFF),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 14.sp, color: const Color(0xFF303133)),
      bodyMedium: TextStyle(fontSize: 13.sp, color: const Color(0xFF606266)),
      bodySmall: TextStyle(fontSize: 12.sp, color: const Color(0xFF909399)),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF409EFF),
      secondary: Color(0xFF67C23A),
      error: Color(0xFFF56C6C),
    ),
  );
}
