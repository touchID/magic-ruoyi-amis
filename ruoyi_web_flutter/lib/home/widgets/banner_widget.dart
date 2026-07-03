import 'package:flutter/material.dart';

import '../home_state.dart';

class BannerWidget extends StatelessWidget {
  final List<BannerModel> banners;

  const BannerWidget({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 400,
                child: PageView.builder(
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: banners[index].color,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        banners[index].title,
                        style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
