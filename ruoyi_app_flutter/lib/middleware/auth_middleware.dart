import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final UserController userController = Get.find<UserController>();
    
    if (route == AppRoutes.login) {
      if (userController.isLoggedIn) {
        return const RouteSettings(name: AppRoutes.main);
      }
      return null;
    }
    
    if (!userController.isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }
    
    return null;
  }
}
