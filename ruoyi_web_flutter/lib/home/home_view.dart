import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'home_logic.dart';
import 'home_state.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_widget.dart';
import 'widgets/flash_sale_widget.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/product_grid_widget.dart';
import 'widgets/top_nav_widget.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = HomeState();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopNavWidget(),
            const HeaderWidget(),
            BannerWidget(banners: state.banners),
            CategoryWidget(categories: state.categories),
            FlashSaleWidget(products: state.flashSaleProducts),
            ProductGridWidget(title: '为你推荐', products: state.recommendProducts),
            ProductGridWidget(title: '热销榜单', products: state.hotProducts),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
