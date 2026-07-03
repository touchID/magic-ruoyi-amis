import 'package:flutter/material.dart';

import '../home_state.dart';

class FlashSaleWidget extends StatelessWidget {
  final List<ProductModel> products;

  const FlashSaleWidget({super.key, required this.products});

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
                    children: const [
                      Text(
                        '限时秒杀',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.flash_on, color: Colors.red),
                      SizedBox(width: 20),
                      Text('距结束'),
                      _CountdownBox(number: '02'),
                      Text(':'),
                      _CountdownBox(number: '30'),
                      Text(':'),
                      _CountdownBox(number: '59'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: products.map((product) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                color: product.color,
                                alignment: Alignment.center,
                                child: Text(
                                  product.name.substring(0, 1),
                                  style: const TextStyle(fontSize: 48, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 5),
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
                                    style: const TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 120,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(
                                  child: Text('立即抢购', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
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

class _CountdownBox extends StatelessWidget {
  final String number;

  const _CountdownBox({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.black,
      child: Center(
        child: Text(
          number,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
