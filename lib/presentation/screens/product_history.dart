import 'package:kurilki/presentation/screens/product.dart';

class ProductHistory extends Product {
  final String data;
  final int count;
  ProductHistory({
    required super.image,
    required super.title,
    required super.price,
    required this.data,
    this.count = 1,
  });
}
