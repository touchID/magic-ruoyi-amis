import 'package:flutter/material.dart';

class BannerModel {
  final String title;
  final Color color;

  BannerModel({required this.title, required this.color});
}

class CategoryModel {
  final int id;
  final String name;
  final String icon;

  CategoryModel({required this.id, required this.name, required this.icon});
}

class ProductModel {
  final int id;
  final String name;
  final Color color;
  final double price;
  final double originalPrice;
  final int sales;

  ProductModel({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    required this.originalPrice,
    required this.sales,
  });
}

class HomeState {
  HomeState() {
    initData();
  }

  late List<BannerModel> banners;
  late List<CategoryModel> categories;
  late List<ProductModel> flashSaleProducts;
  late List<ProductModel> recommendProducts;
  late List<ProductModel> hotProducts;

  void initData() {
    banners = [
      BannerModel(title: '限时特惠', color: Colors.red),
      BannerModel(title: '数码专场', color: Colors.blue),
      BannerModel(title: '时尚精选', color: Colors.purple),
    ];

    categories = [
      CategoryModel(id: 1, name: '数码', icon: '📱'),
      CategoryModel(id: 2, name: '服装', icon: '👔'),
      CategoryModel(id: 3, name: '家居', icon: '🏠'),
      CategoryModel(id: 4, name: '食品', icon: '🍎'),
      CategoryModel(id: 5, name: '美妆', icon: '💄'),
      CategoryModel(id: 6, name: '运动', icon: '⚽'),
      CategoryModel(id: 7, name: '图书', icon: '📚'),
      CategoryModel(id: 8, name: '母婴', icon: '🍼'),
    ];

    flashSaleProducts = [
      ProductModel(
        id: 1,
        name: '无线蓝牙耳机 Pro',
        color: Colors.grey[300]!,
        price: 199.0,
        originalPrice: 399.0,
        sales: 2341,
      ),
      ProductModel(
        id: 2,
        name: '智能手表运动版',
        color: Colors.black,
        price: 599.0,
        originalPrice: 999.0,
        sales: 1567,
      ),
      ProductModel(
        id: 3,
        name: '便携式充电宝 20000mAh',
        color: Colors.blue[300]!,
        price: 89.0,
        originalPrice: 159.0,
        sales: 5678,
      ),
      ProductModel(
        id: 4,
        name: '机械键盘青轴',
        color: Colors.grey[800]!,
        price: 159.0,
        originalPrice: 259.0,
        sales: 890,
      ),
    ];

    recommendProducts = [
      ProductModel(
        id: 5,
        name: '纯棉T恤男夏季新款',
        color: Colors.white,
        price: 69.0,
        originalPrice: 129.0,
        sales: 8934,
      ),
      ProductModel(
        id: 6,
        name: '休闲运动鞋女',
        color: Colors.pink[300]!,
        price: 199.0,
        originalPrice: 359.0,
        sales: 4521,
      ),
      ProductModel(
        id: 7,
        name: '家用空气净化器',
        color: Colors.grey[200]!,
        price: 499.0,
        originalPrice: 799.0,
        sales: 2134,
      ),
      ProductModel(
        id: 8,
        name: '坚果礼盒大礼包',
        color: Colors.orange[300]!,
        price: 128.0,
        originalPrice: 198.0,
        sales: 6789,
      ),
      ProductModel(
        id: 9,
        name: '口红礼盒套装',
        color: Colors.red[400]!,
        price: 299.0,
        originalPrice: 499.0,
        sales: 3421,
      ),
      ProductModel(
        id: 10,
        name: '瑜伽垫加厚款',
        color: Colors.purple[300]!,
        price: 79.0,
        originalPrice: 139.0,
        sales: 2345,
      ),
      ProductModel(
        id: 11,
        name: '儿童绘本套装',
        color: Colors.yellow[300]!,
        price: 88.0,
        originalPrice: 158.0,
        sales: 5678,
      ),
      ProductModel(
        id: 12,
        name: '婴儿纸尿裤XL码',
        color: Colors.blue[200]!,
        price: 139.0,
        originalPrice: 199.0,
        sales: 9876,
      ),
    ];

    hotProducts = [
      ProductModel(
        id: 13,
        name: '4K高清电视55英寸',
        color: Colors.black,
        price: 2999.0,
        originalPrice: 3999.0,
        sales: 1234,
      ),
      ProductModel(
        id: 14,
        name: '轻薄笔记本电脑',
        color: Colors.grey[300]!,
        price: 4999.0,
        originalPrice: 6999.0,
        sales: 890,
      ),
      ProductModel(
        id: 15,
        name: '无线吸尘器家用',
        color: Colors.grey[400]!,
        price: 1299.0,
        originalPrice: 1899.0,
        sales: 3456,
      ),
      ProductModel(
        id: 16,
        name: '咖啡机全自动',
        color: Colors.brown[300]!,
        price: 899.0,
        originalPrice: 1399.0,
        sales: 1567,
      ),
    ];
  }
}
