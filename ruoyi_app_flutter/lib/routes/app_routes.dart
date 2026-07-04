import 'package:get/get.dart';
import '../pages/login/login_page.dart';
import '../pages/main/main_page.dart';
import '../pages/common_chat/common_chat_page.dart';
import '../pages/shop_chat/shop_chat_page.dart';
import '../pages/shop_chat_history/shop_chat_history_page.dart';
import '../pages/shop_chat_history_details/shop_chat_history_details_page.dart';
import '../pages/shop_chat_history_list/shop_chat_history_list_page.dart';
import '../middleware/auth_middleware.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String commonChat = '/common_chat';
  static const String shopChat = '/shop_chat';
  static const String shopChatHistory = '/shop_chat_history';
  static const String shopChatHistoryDetails = '/shop_chat_history_details';
  static const String shopChatHistoryList = '/shop_chat_history_list';

  static final List<GetPage> routes = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: main,
      page: () => const MainPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: commonChat,
      page: () => const CommonChatPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: shopChat,
      page: () => ShopChatPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: shopChatHistory,
      page: () => const ShopChatHistoryPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: shopChatHistoryDetails,
      page: () => const ShopChatHistoryDetailsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: shopChatHistoryList,
      page: () => const ShopChatHistoryListPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}