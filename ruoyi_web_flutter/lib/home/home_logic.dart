import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // 页面重新显示：刷新列表、重连ws

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // 页面隐藏：停止定时器、暂停轮询
  }

}
