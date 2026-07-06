import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../pages/login/login_page.dart';
import '../pages/main/main_page.dart';
import '../pages/common_chat/common_chat_page.dart';
import '../pages/shop_chat/shop_chat_page.dart';
import '../pages/shop_chat_history/shop_chat_history_page.dart';
import '../pages/shop_chat_history_details/shop_chat_history_details_page.dart';
import '../pages/shop_chat_history_list/shop_chat_history_list_page.dart';
import '../controllers/user_controller.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String commonChat = '/common_chat';
  static const String shopChat = '/shop_chat';
  static const String shopChatHistory = '/shop_chat_history';
  static const String shopChatHistoryDetails = '/shop_chat_history_details';
  static const String shopChatHistoryList = '/shop_chat_history_list';

  static String initialLocation = login;

  static String? _redirect(BuildContext context, GoRouterState state) {
    final UserController userController = Get.find<UserController>();
    bool isLoggedIn = userController.isLoggedIn;
    String route = state.matchedLocation;

    if (route == login || route == '$login/') {
      if (isLoggedIn) {
        return main;
      }
      return null;
    }

    if (!isLoggedIn) {
      return login;
    }

    return null;
  }

  static final GoRouter router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: commonChat,
        builder: (context, state) => const CommonChatPage(),
      ),
      GoRoute(
        path: shopChat,
        builder: (context, state) => ShopChatPage(),
      ),
      GoRoute(
        path: shopChatHistory,
        builder: (context, state) => const ShopChatHistoryPage(),
      ),
      GoRoute(
        path: shopChatHistoryDetails,
        builder: (context, state) => const ShopChatHistoryDetailsPage(),
      ),
      GoRoute(
        path: shopChatHistoryList,
        builder: (context, state) => const ShopChatHistoryListPage(),
      ),
    ],
    redirect: _redirect,
  );
}