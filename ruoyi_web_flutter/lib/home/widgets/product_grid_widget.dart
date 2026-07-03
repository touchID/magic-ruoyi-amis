import 'package:flutter/material.dart';

import '../home_state.dart';

class ProductGridWidget extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const ProductGridWidget({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text('更多', style: TextStyle(color: Colors.grey)),
                      const Icon(Icons.arrow_right, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    children: products.map((product) {
                      return Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  color: product.color,
                                  alignment: Alignment.center,
                                  child: Text(
                                    product.name.substring(0, 1),
                                    style: const TextStyle(fontSize: 48, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¥${product.price}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '¥${product.originalPrice}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '已售${product.sales}',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}