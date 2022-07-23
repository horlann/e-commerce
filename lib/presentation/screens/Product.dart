import 'package:flutter/material.dart';

class Product {
  final String image, title;
  final int price;
  final Color bgColor;
  final int count;

  Product({
    required this.image,
    required this.title,
    required this.price,
    this.count = 1,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}
