import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import './config/theme_config.dart';
import './routes/app_routes.dart';
import './api/http.dart';
import './utils/storage.dart';
import './controllers/user_controller.dart';

String initialRoute = AppRoutes.login;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.init();
  HttpUtil.init();
  Get.put(UserController());
  
  await Get.find<UserController>().init();
  if (Get.find<UserController>().isLoggedIn) {
    initialRoute = AppRoutes.main;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: '若依管理',
          theme: ThemeConfig.lightTheme,
          initialRoute: initialRoute,
          getPages: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
