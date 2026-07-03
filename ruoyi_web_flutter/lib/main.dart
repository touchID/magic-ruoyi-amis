import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'home/home_binding.dart';
import 'home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 等待字体全部加载完成再启动界面
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '商城首页',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        primaryColor: Colors.red,
      ),
      initialBinding: HomeBinding(),
      home: const HomePage(),
    );
  }
}
