import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '商城首页',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: '搜索商品',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: const Text(
                            '搜索',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.red),
                    const SizedBox(width: 5),
                    const Text('400-888-8888'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
