import 'package:flutter/material.dart';

class TopNavWidget extends StatelessWidget {
  const TopNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      '首页',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    _buildNavItem('电脑办公'),
                    const SizedBox(width: 20),
                    _buildNavItem('数码配件'),
                    const SizedBox(width: 20),
                    _buildNavItem('手机通讯'),
                    const SizedBox(width: 20),
                    _buildNavItem('家用电器'),
                    const SizedBox(width: 20),
                    _buildNavItem('服装配饰'),
                  ],
                ),
                Row(
                  children: [
                    _buildNavItem('登录'),
                    const SizedBox(width: 20),
                    _buildNavItem('注册'),
                    const SizedBox(width: 20),
                    const Icon(Icons.shopping_cart, color: Colors.red),
                    const SizedBox(width: 5),
                    const Text('购物车'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey, fontSize: 14),
    );
  }
}
