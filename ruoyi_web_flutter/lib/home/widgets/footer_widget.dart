import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Text('关于我们', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('公司简介', style: TextStyle(color: Colors.grey)),
                          Text('联系我们', style: TextStyle(color: Colors.grey)),
                          Text('加入我们', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Text('客户服务', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('帮助中心', style: TextStyle(color: Colors.grey)),
                          Text('退换货政策', style: TextStyle(color: Colors.grey)),
                          Text('配送说明', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Text('支付方式', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('在线支付', style: TextStyle(color: Colors.grey)),
                          Text('货到付款', style: TextStyle(color: Colors.grey)),
                          Text('分期付款', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Text('关注我们', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('官方微信', style: TextStyle(color: Colors.grey)),
                          Text('官方微博', style: TextStyle(color: Colors.grey)),
                          Text('客服热线：400-888-8888', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),
                const Text('Copyright 2024 商城首页 All Rights Reserved', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
