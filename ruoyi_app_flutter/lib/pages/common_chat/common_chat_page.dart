import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CommonChatPage extends StatelessWidget {
  const CommonChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('聊天功能开发中'),
      ),
    );
  }
}
